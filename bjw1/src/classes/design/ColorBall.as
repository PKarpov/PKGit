package classes.design 
{
	import classes.utils.Easing;
//	import flash.display.BitmapData;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author fish
	 */
	public class ColorBall extends Sprite 
	{
		protected var my_ball:Image;
		public var score:int;
		public var col:int = -1;
		public var row:int = -1;
		public var ID:int;

		static public const START_DRAG:String = "START_DRAG"; 
		static public const ENDING_MOVE:String = "ENDING_MOVE"; 
		protected var all_id:Vector.<Image> = new Vector.<Image>();
		protected var route:Vector.<int>;
		
		public function ColorBall(_x:int,_y:int) 	{
			x = _x;
			y = _y;
// создаем образы всех шариков а потом управляем только их видимостью 
			for (var _i:int = 0; _i < Design.num_types ; _i++) {
				var _img:Image = new Image(Design.images[_i]);
				_img.x = _img.y = -20;
				_img.filter = BlurFilter.createDropShadow(5, .785, 0, .7, 3, 1);
				_img.visible = false;
				addChild(_img);
				all_id.push(_img);
			}
			my_ball = all_id[0];
			my_ball.visible = true;
		}
				
		public function initBall(_id:int):void {
			ID = _id;
			my_ball.visible = false;
			my_ball = all_id[ID];
			my_ball.visible = true;
		}
		
		protected function getNumberSteps(_x:int,_y:int, _speed:int):int {
			var _dx:int = _x - x;
			var _dy:int = _y - y;
			var _distance:Number = Math.sqrt(_dx * _dx + _dy * _dy);
			var _step:int = Math.round(_distance/_speed)
			return _step
		}
		
		public function newFakeBall (_x:int, _y:int, _id:int, _step:int, _score:int = 1):void {
			x = _x;
			y = _y;
			score = _score;
			initBall(_id);
			_step += getNumberSteps(Design.counter_x, Design.counter_y,Design.speed2);
			route = Easing.Quad010(x, y, Design.counter_x, Design.counter_y, _step);
			addEventListener(EnterFrameEvent.ENTER_FRAME, flyToPlace);
		}
		
		protected function flyToPlace(e:Event):void {
			if (route.length) {
				rotation += Math.PI/18;
				x = route.shift();
				y = route.shift();
			} else {
				removeEventListener(EnterFrameEvent.ENTER_FRAME, flyToPlace);
				dispatchEventWith(ColorBall.ENDING_MOVE, false, { col:col, row:row, id:ID, score:score, color:Design.id_colors[ID]} );
			}
		}
	}
}