package view.items 
{
	import controller.events.CalculatorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import model.CModel;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author fish
	 */
	public class Board  extends Sprite
	{

		private var board:TextField;
		private var timer:Timer = new Timer(120, 6);
		private var new_value:String;
		private var limit:int = 10;
		
		[Inject(source="logic.board", bind="true")]
        public function set showNewVallue(value:String):void	{
			if (timer.running) {
				new_value = value;
				return;
			}
			if (value.length < limit) {
				board.text = value;
			} else {
				dispatchEvent(new CalculatorEvent(CalculatorEvent.DISPLAY_BUG));
				new_value = '0';  
				board.text = 'ERROR';
				timer.start();
			}
        }
		
		public function Board(_color:uint = 0xff0000)	{
			board = new TextField(40, 40, '0', "font00", 40, _color);
			board.border = true;
			board.hAlign = HAlign .RIGHT;
			addChild(board);
			timer.addEventListener(TimerEvent.TIMER, blinking);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, stopBlink);
		}
		
		
		private function blinking(e:TimerEvent):void {
			visible = !visible;
		}
		
		private function stopBlink(e:TimerEvent):void {
			timer.reset();
			visible = true;
			board.text = new_value;
		}
		
		public function chengeSize(_w:int, _h:int, _size:int):void	{
			board.width = _w;
			board.height = _h;
			board.fontSize = _size;
			var _old:String = board.text;
			limit = textFieldLength (board);
			board.text = _old;
			//board.text = _old.length < board.text.length? _old:'0';
		}
		
		private function textFieldLength (_tf:TextField):int { // определяем максимальную разрядность поля
			_tf.text = '0';
			var _tmp0:int ;
			var _tmp1:int = Rectangle(board.textBounds).width;
			do {
				_tmp0 = _tmp1;
				_tf.text += '0';
				_tmp1 = Rectangle(_tf.textBounds).width;
			} while (_tmp0 < _tmp1);
			return _tf.text.length;
		}
	}
}