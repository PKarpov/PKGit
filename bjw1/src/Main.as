package 
{
	import starling.core.Starling;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[SWF(width="500", height="500", frameRate="60", backgroundColor="#ffffff")]

	public class Main extends Sprite	{
		private var mStarling:Starling;

		public function Main()	{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			mStarling = new Starling(Game, stage);
			mStarling.antiAliasing = 2;
			mStarling.start();
		}
	}
}