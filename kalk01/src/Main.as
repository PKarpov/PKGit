package 
{
	import starling.core.Starling;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[SWF(width="500", height="700", frameRate="31", backgroundColor="#ffffff")]

	public class Main extends Sprite	{
		private var mStarling:Starling;

		public function Main()	{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			mStarling = new Starling(CalculatorMain, stage);
			mStarling.antiAliasing = 4;
			mStarling.start();
		}
	}
}