package classes.add 
{
	import classes.design.GameBall;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	/**
	 * ...
	 * @author fish
	 */
	public class Hint extends Sprite
	{
		private var pause:Timer = new Timer(5000, 1);
		private var next:Timer = new Timer(2000);
		private var variant:Vector.<GameBall>;
		private var ball:GameBall;
		private var num:int;
		
		public function Hint() {
			pause.addEventListener(TimerEvent.TIMER, startShowHints);
		}
		
		public function hintOff(e:Event):void {
			pause.reset();
			next.reset();
			if (hasEventListener(EnterFrameEvent.ENTER_FRAME)) removeEventListener(EnterFrameEvent.ENTER_FRAME, rotationHint);
			if (next.hasEventListener(TimerEvent.TIMER)) next.removeEventListener(TimerEvent.TIMER, switchHint);
			if (ball) ball.scaleX = ball.scaleY = 1; 
		}
		
		private function switchHint(e:TimerEvent):void {
			if (ball) ball.scaleX = ball.scaleY = 1; 
			num = ++num >= variant.length?0:num; 
			ball = variant[num];
			ball.scaleX = ball.scaleY = 1.2; 
		}
		
		public function rebootHint (_variant:Vector.<GameBall>):void {
			variant = _variant;
			pause.reset();
			pause.start();
		}
		
		private function startShowHints(e:TimerEvent):void {
			num = 0;
			ball = variant[0];
			ball.scaleX = ball.scaleY = 1.2; 
			next.addEventListener(TimerEvent.TIMER, switchHint);
			next.start();
			addEventListener(EnterFrameEvent.ENTER_FRAME, rotationHint);
		}
		
		
		protected function rotationHint(e:Event):void {
			ball.rotation += Math.PI/100;
		}
	}

}