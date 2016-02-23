package 
{
	import classes.add.Hint;
	import classes.design.ColorBall;
	import classes.design.GameBall;
	import classes.design.Design;
	import classes.GameLogic;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	/**
	 * ...
	 * @author fish
	 */
	public class Game extends GameLogic	{
		public static var game_field:Sprite;
		private var fly_balls:int = 0;//колличество летающих шаров
		private var design:Design;
		private var fake_ball:Vector.<ColorBall> = new Vector.<ColorBall>();
		private var speed_fake_ball:int;
		private var old_id:int = 0;
		private var sleep:Timer = new Timer(300, 1);
		private var hint:Hint = new Hint();
		public static var ready:Boolean = true;
		
		public function Game() 	{
			design = new Design();
			game_field = new Sprite;
			game_field.x = Design.x0; 
			game_field.y = Design.y0; 
			addChild(design);
			addChild(hint);
			design.addEventListener(Design.CLICK_ON_BUTTON, clickButtonHendler);
			matrix_ball = new Vector.<Vector.<GameBall > >()   ;
			var _ball:GameBall;
			for (var _col:uint = 0; _col < Design.num_columns; _col++ ) {//заполняем поле шарами
				var array_ball:Vector.<GameBall > =  new Vector.<GameBall>()  ;
				for (var _row:uint = 0; _row < Design.num_rows;_row++ ) {
					_ball = new GameBall(endDragBall,_col,_row);
					array_ball.push(_ball);
					game_field.addChild(_ball);
					_ball.addEventListener(ColorBall.START_DRAG, hint.hintOff);
				}
				matrix_ball.push(array_ball); 
			}
			var _i:int = 0;
			do{    // создаем массив с пустышками
				fake_ball.unshift(new ColorBall(0, 0));
				fake_ball[0].addEventListener(ColorBall.ENDING_MOVE, addScore);
				fake_ball[0].filter = new BlurFilter();
				fake_ball[0].scaleX = fake_ball[0].scaleY = .9;
			}while (++_i < 20);
			sleep.addEventListener(TimerEvent.TIMER, wakeUp);
		}
				
//		private function pushGame(e:Event):void	{	if (arr_win.length || findWinnings()) 	refreshField()};//ручной запуск
		
		protected function clickButtonHendler(e:Event):void {
			startNewGame();
		}
		
		protected function startNewGame ():void {
			newMatrix();
			addChild(game_field);
			hint.rebootHint(arr_variants);
			ready = true;
		}
		
		protected function endGame ():void {
			hint.hintOff(null);
			removeChild(game_field);
			design.endGame();
		}
		
// проверка валидности рокировки
		protected function endDragBall (_c0:int, _r0:int, _dx:int, _dy:int, _id:int):Boolean {
			if (Math.abs(_dx) > Math.abs(_dy)){// определяем в каком направлении задумывалась ротация
				var _r1:int = _r0;
				var _c1:int = _dx < 0? (_c0 - 1):(_c0 + 1);
			} else {
				var _c1:int = _c0;
				var _r1:int = _dy < 0? (_r0 - 1):(_r0 + 1);
			}
			if (_c1 < 0 || _c1 >= Design.num_columns) return false;
			if (_r1 < 0 || _r1 >= Design.num_rows) return false;
			var _ball0:GameBall = matrix_ball[_c0][_r0];
			var _ball1:GameBall = matrix_ball[_c1][_r1];
			matrix_ball[_c0][_r0] = _ball1;//делаем временную рокировку для проверки
			matrix_ball[_c1][_r1] = _ball0;
			if (checkThisBallForWin(_c1, _r1, _id) || checkThisBallForWin(_c0, _r0, _ball1.ID)) {
				ready = false;
				fly_balls += 2;
				_ball0.addEventListener(ColorBall.ENDING_MOVE, registerBallInMatrix);
				_ball1.addEventListener(ColorBall.ENDING_MOVE, registerBallInMatrix);
				_ball0.startFlyToPlace(_c1, _r1);// запускаем визуальную рокировку
				_ball1.startFlyToPlace(_c0, _r0);//
				for each (_ball0 in arr_win)	{
					_ball0.scaleX = _ball0.scaleY = 1.15;	
					_ball0.filter = BlurFilter.createGlow(0xffff00, 1, 7, .5);
				}
				return true;
			} else {
				matrix_ball[_c0][_r0] = _ball0;//отменяем рокировку 
				matrix_ball[_c1][_r1] = _ball1;
				return false;
			}
		}
// обновляем состояние поля
		protected function refreshField ():void {
			//var _tt:String = arr_win.length+' <';
			//for (var i:int = 0; i < arr_win.length; i++) {
				//_tt += arr_win[i].col + '~' + arr_win[i].row + '/';
			//}
			//trace(_tt+'>')
			var _ball:GameBall;
			speed_fake_ball = arr_win.length * 3;
			
			var _col:int;
			var _row:int;
			if (arr_win[0].col == arr_win[1].col) {// если присутствует вертикальный фрагмент
				_col = arr_win[0].col;
				var vertical:Vector.<GameBall> = new Vector.<GameBall>();// выносим его в отдельный массив
				do {
					vertical.push(arr_win.shift());
				} while (arr_win.length && arr_win[0].col == _col);
				var _len:int = vertical.length;
				// обрушиваем все шары которые выше фрагмента 
				_row = vertical[vertical.length-1].row;
				while (--_row >= 0) {
					_ball = matrix_ball[_col][_row];
					if (_ball.hasEventListener(ColorBall.ENDING_MOVE)) trace ('121 ??????? '+_ball.col+' '+_ball.row)
					++fly_balls;
					_ball.addEventListener(ColorBall.ENDING_MOVE, registerBallInMatrix);
					_ball.startFlyToPlace(_col, (_row+_len),15);
				}
				// поднимаем и обрушиваем шары из вертикального фрагмента
				var _dr:int = vertical[0].row + 1;
				do { 
					_ball = vertical.shift();
					newOldBall(_ball, (_ball.row - _dr), (vertical.length),(3+_dr*2));
				} while (vertical.length);
			}
			while (arr_win.length){ // горизонтальный фрагмент 
				_ball = arr_win.shift();
				_col = _ball.col;
				_row = _ball.row;
				newOldBall(_ball, -1, 0, 5);
				while (--_row>=0){
					_ball = matrix_ball[_col][_row];
					if (_ball.hasEventListener(ColorBall.ENDING_MOVE)) trace ('140 ??????? '+_ball.col+' '+_ball.row)
					++fly_balls;
					_ball.addEventListener(ColorBall.ENDING_MOVE, 	registerBallInMatrix);
					_ball.startFlyToPlace(_col, (_row+1));
				}
			}
			function newOldBall(_ball:GameBall, _r0:int, _r1:int, _step:int = 5):void {//превращаем исчезнувшие шары в новые
				var _fake_ball:ColorBall = fake_ball.pop();//двойник для полета в счетчик
				_fake_ball.newFakeBall((_ball.x+Design.x0), (_ball.y+Design.y0),_ball.ID, speed_fake_ball);
				addChild(_fake_ball);
				speed_fake_ball -= 3;
				_ball.y = Design.dxy * _r0;// поднимаем шар выше поля
				do { 
					var _new_id:int = Math.floor(Math.random() * Design.num_types);
				} while (_new_id == old_id);
				_ball.initBall(old_id = _new_id);
				if (_ball.hasEventListener(ColorBall.ENDING_MOVE)) trace ('156 ??????? '+_ball.col+' '+_ball.row)
				++fly_balls;
				_ball.addEventListener(ColorBall.ENDING_MOVE, 	registerBallInMatrix);
				_ball.startFlyToPlace(_ball.col, _r1, 21);// запускаем полет на новую позицию
			}
		}
		
		private function addScore(e:Event):void { // обновляем счет
			var _ball:ColorBall = ColorBall(e.target);
			design.setCounter1(e.data.score, e.data.color);
			removeChild(_ball);
			fake_ball.unshift(_ball);
		}
			
		private function registerBallInMatrix(e:Event):void  {// регистрируем шары в матрице после перемещения
			var _ball:GameBall = GameBall(e.target);
			_ball.removeEventListener(ColorBall.ENDING_MOVE, registerBallInMatrix);
			matrix_ball[e.data.col][e.data.row] = _ball;
			if (--fly_balls > 0) return;
			if (arr_win.length) {
				for each (_ball in arr_win)	{
					_ball.scaleX = _ball.scaleY = 1;
					_ball.filter.dispose();
				}
				refreshField(); 
			} else if (findWinnings()) {
				for each (_ball in arr_win)	{
					_ball.scaleX = _ball.scaleY = 1.15;	
					_ball.filter = BlurFilter.createGlow(0xffff00, 1, 7, .5);
				}
				sleep.start();
			} else {
				if (presenceСontinue() == 0){
					endGame();
				} else {
					trace("Memory=" + System.totalMemory +' Variants=' + arr_variants.length);
					ready = true;
					hint.rebootHint(arr_variants);
				}
			}
		}
		private function wakeUp(e:TimerEvent):void 	{
			var _ball:GameBall;
			for each (_ball in arr_win)	{
				_ball.scaleX = _ball.scaleY = 1;
				_ball.filter.dispose();
			}
			refreshField(); 
		}

	}

}