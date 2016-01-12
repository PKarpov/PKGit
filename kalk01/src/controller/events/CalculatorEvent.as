package controller.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author fish
	 */
	public class CalculatorEvent extends Event 
	{
		static public const BUTTON_PRESSED:String = 'BUTTON_PRESSED';
		static public const DISPLAY_BUG:String = 'DISPLAY_BUG';
	
		public var info:String;
		
		public function CalculatorEvent(type:String, buttonPressed:String = '') 
		{
			super(type, true, false);
			info = buttonPressed;
		}
		
		public function clone():Event {
			return new CalculatorEvent(this.type, this.info);
		}
		
	}

}