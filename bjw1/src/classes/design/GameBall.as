package classes.design 
{
	import classes.design.Design;
	import classes.utils.Easing;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author fish
	 */
	public class GameBall extends ColorBall {
		protected var x0:int;
		protected var y0:int;
		protected var dx:int;
		protected var dy:int;
		protected var drag:Boolean = false;
		
		protected var max_dxy:int = Design.dxy;
//		static public const STOP_DRAG_BALL:String = "STOP_DRAG_BALL"; 
		protected var endDragBall:Function;// обработчик для события окончания перетаскивания шарика
		
		public function GameBall(_ed:Function,_col:int,_row:int) {
			super ((_col*Design.dxy),(_row*Design.dxy));
			endDragBall = _ed;
			col = _col;
			row = _row;
			addEventListener(TouchEvent.TOUCH, touchBallHandler);
			rotation = Math.random()*Math.PI*2;
		}
		
		private function touchBallHandler(e : TouchEvent):void {
			if (!Game.ready) return;
			var touch:Touch = e.getTouch(Game.game_field);
			if (!touch || touch.phase == TouchPhase.HOVER) return;
			var position:Point = touch.getLocation(Game.game_field);
			if (!drag && touch.phase == TouchPhase.BEGAN) {
				x0 = x;
				y0 = y;
				dx = position.x - x;
				dy = position.y - y;
				scaleX = scaleY = 1.12;
				rotation += Math.PI/18;
				parent.setChildIndex(this, parent.numChildren - 1);
				drag = true;
				filter = BlurFilter.createGlow(0xffff00, 1, 7, .5);
				dispatchEventWith(ColorBall.START_DRAG);
			} else if (drag && touch.phase == TouchPhase.ENDED) {
				stopDrag();
			} else if (drag && touch.phase == TouchPhase.MOVED) {
				var _xx:int = position.x - x0;
				var _yy:int = position.y - y0;
				var _distance:Number = Math.sqrt(_xx * _xx + _yy * _yy);
				if (_distance < (Design.dxy*1.5)) {
					x = position.x - dx;
					y = position.y - dy;
				}else {
					stopDrag();
				}
			}
		}
		
		private function stopDrag ():void {
			scaleX = scaleY = 1;
			drag = false;
			filter.dispose();
			var _xx:int = x - x0;
			var _yy:int = y - y0;
			var _distance:Number = Math.sqrt(_xx * _xx + _yy * _yy);
// dispatchEvent(new Event(ColorBall.STOP_DRAG_BALL)); 
// вместо диспача работаем через переданную функцию endDragBall (передаем данные и сразу получаем ответ)
			if (_distance > (width / 2) && endDragBall(col,row,_xx,_yy,ID)) {
					return;// отдаем управление игре
			} else {
				route = Easing.Quad010(x, y, x0, y0, (5 + Math.round(_distance / 25)));
				addEventListener(EnterFrameEvent.ENTER_FRAME, flyToPlace);
			}
		}
		
		public function startFlyToPlace(_c:int, _r:int, _step:int = 9):void {
			col = _c;
			row = _r;
//			my_ball.cc.text = _c;
//			my_ball.rr.text = _r;
			var _xx:int = _c * Design.dxy;
			var _yy:int = _r * Design.dxy;
			var _step:int = Design.add_step + getNumberSteps(_xx, _yy,Design.speed1);
			route = Easing.Quad010(x, y, _xx, _yy, _step);
			addEventListener(EnterFrameEvent.ENTER_FRAME, flyToPlace);// реализовано у предка
		}
	}

}