package classes 
{
	import classes.design.GameBall;
	import classes.design.Design;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author fish
	 */

//Класс логики для игры подобного типа с произвольной конфигурацией поля
	public class GameLogic extends Sprite {
		protected var arr_win:Vector.<GameBall > = new  Vector.<GameBall >();//шары выиграшной комбинации
		protected var matrix_ball:Vector.<Vector.<GameBall >  > ;//матрица шаров на поле
		protected var arr_variants:Vector.<GameBall > ;// подсказки (возможные ходы)

		protected function newMatrix():void {// Создает новую раскладку камней на поле
			var _col:int;
			var _row:int;
			var _ID:int;
			var _ball:GameBall;
			var _time:int = getTimer();
			var _n:int;
			do {//в начале игры не должно быть выиграшных комбинаций и должно быть не менее xx(7) доступных перемещений
				++_n;
				for (_col = 0; _col < Design.num_columns; ++_col) {//создаем новую раскладку
					for (_row = 0; _row < Design.num_rows; ++_row) {
						_ball = GameBall(matrix_ball[_col][_row]);
						_ball.ID = Math.floor(Math.random() * Design.num_types);
					}
				}
			} while ((findWinnings() || presenceСontinue() < 7));//проверяем выполнение условий 
			for each (var _vector:Vector.<GameBall > in matrix_ball){
				for each (_ball in _vector){
					_ball.initBall(_ball.ID);
				}
			}
			trace(_n+' Time = ' + (getTimer() - _time));
		}

		protected function presenceСontinue():int {//проверяем все возможные рокировки на возможность выиграша(продолжения игры)
//			var _time:int = getTimer();
			var _test_col:int;
			var _test_row:int;
			var _new_col:int;
			var _new_row:int;
			var _ball_test:GameBall;
			var _ball_new:GameBall;
			var _ID:int;
			var _hint_xy:Point;
			arr_variants = new Vector.<GameBall >() ;//варианты допустимых рокировок
			for (_test_row = 0; _test_row < Design.num_rows; ++_test_row) {
				for (_test_col = 0; _test_col < Design.num_columns; ++_test_col) {
					_ball_test = GameBall(matrix_ball[_test_col][_test_row]);//берем шар  
					_ID = _ball_test.ID;//получаем его цвет
					_new_row = _test_row;
					_new_col = _test_col + 1;//проверяем вправо
					if (_new_col < Design.num_columns && _Check()) continue;
					_new_col = _test_col - 1;//проверяем влево
					if (_new_col >= 0 && _Check()) continue;
					_new_col = _test_col;//проверяем вниз
					_new_row = _test_row + 1;
					if (_new_row < Design.num_rows && _Check()) continue;
					_new_row = _test_row - 1;//проверяем вверх
					if (_new_row >= 0 && _Check()) continue;
				}
			}
//			trace('presenceСontinue time='+(getTimer()-_time)+ ' variants='+arr_variants.length)
			return arr_variants.length;
			function _Check():Boolean {//вложенная функция проверки
				var _yes:Boolean = false;
				_ball_new = GameBall(matrix_ball[_new_col][_new_row]);
				if (_ball_new.ID != _ID) {//шары для рокировки разного цвета
					matrix_ball[_new_col][_new_row] = _ball_test;//
					matrix_ball[_test_col][_test_row] = _ball_new;//временно меняем шары местами
					if (checkThisBallForWin(_new_col,_new_row,_ID)) {//проводим проверку на выиграш 
						arr_variants.push(_ball_test);//запоминаем для подсказки
						_yes = true;
					}
					matrix_ball[_test_col][_test_row] = _ball_test;//
					matrix_ball[_new_col][_new_row] = _ball_new;//возвращаем как было
				}
				return _yes;
			}
		}
		
		protected function findHorizontalLineInPoint(_col:int, _row:int, _id:int,_main:Boolean = true):Vector.<GameBall> {
			var _win_row:Vector.<GameBall> = new Vector.<GameBall>();
			var _cc:int = _col;
			while (--_cc >= 0 && matrix_ball[_cc][_row].ID == _id) {//смещаемя влево
			}
			while (++_cc < Design.num_columns && matrix_ball[_cc][_row].ID == _id) {//проверяем вправо
				if (!_main && _cc == _col) continue;// пропускаем главный шар чтобы не было дублирования
				_win_row.push(matrix_ball[_cc][_row]);
			}
			if (_win_row.length < (_main?3:2))_win_row.length = 0;
			return _win_row; //в порядке возрастания
		}
		
		protected function findVerticalLineInPoint(_col:int, _row:int, _id:int):Vector.<GameBall> {
			var _win_col:Vector.<GameBall> = new Vector.<GameBall>();
			var _rr:int = _row;
			while (++_rr < Design.num_rows && matrix_ball[_col][_rr].ID == _id) {//опускаемся вниз
			}
			while (--_rr >= 0 && matrix_ball[_col][_rr].ID == _id) {//проверяем вверх
				_win_col.push(matrix_ball[_col][_rr]);
			}
			if (_win_col.length < 3)_win_col.length = 0;
			return _win_col;//в порядке снизу вверх
		}
		
		protected function findWinnings():Boolean {
			var _ball:GameBall;
			var _col:int;
			var _row:int;
			var _id:int;
			var _tmp_win:Vector.<GameBall> = new Vector.<GameBall>();
			arr_win.length = 0;	
COL:		for (_col = 0; _col < Design.num_columns; ++_col) {	// проверяем все колонки слева направо сверху вниз
				_id = - 1 ;
				for (_row = 0; _row < Design.num_rows; _row++) {
					_ball = matrix_ball[_col][_row];
					if (_ball.ID == _id) {
						_tmp_win.push(_ball);
					} else {
						if (_tmp_win.length > 2) break COL;// нашли
						_id = _ball.ID;
						_tmp_win.length = 1;
						_tmp_win[0] = _ball;
					}					
				}
				if (_tmp_win.length > 2) break;// нашли (отрезок в самом низу колонки)
			}
			if (_tmp_win.length > 2) {
				arr_win = arr_win.concat(_tmp_win.reverse());
				for each(_ball in arr_win) {
					_tmp_win = findHorizontalLineInPoint(_ball.col, _ball.row, _ball.ID, false);
					if (_tmp_win.length) {
						arr_win = arr_win.concat(_tmp_win);
						break;
					}
				}
				return true; // есть результат 
			}
ROW:		for (_row = 0; _row < Design.num_rows; ++_row) {// проверяем все строки сверху вниз слева направо 
				_id = - 1 ;
				for (_col = 0; _col < Design.num_columns; ++_col) {	
					_ball = matrix_ball[_col][_row];
					if (_ball.ID == _id) {
						_tmp_win.push(_ball);
					} else {
						if (_tmp_win.length > 2) break ROW;// нашли
						_id = _ball.ID;
						_tmp_win.length = 1;
						_tmp_win[0] = _ball;
					}					
				}
				if (_tmp_win.length > 2) break;// нашли (отрезок в самом конце строки)
			}
			if (_tmp_win.length > 2) arr_win = _tmp_win;
			return arr_win.length > 2;
		}
		
		protected function checkThisBallForWin(_col:int, _row:int, _ID:int):Boolean {
			arr_win = findVerticalLineInPoint(_col, _row, _ID);
			if (arr_win.length){
				 arr_win = arr_win.concat(findHorizontalLineInPoint(_col, _row, _ID,false));
			} else {
				 arr_win = arr_win.concat(findHorizontalLineInPoint(_col, _row, _ID,true));
			}
			return arr_win.length;
		}

	}
}