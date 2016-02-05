package 
{
	import flash.display.Sprite;
	import singl.SinglWin;
	import stat.StatWin;
	
	/**
	 * ...
	 * @author fish
	 */
	public class StartWin extends Sprite 
	{
		private var frame0:StatWin;
		private var frame1:SinglWin;
		
		public function StartWin() 
		{
			frame0 = new StatWin(10,15);
<<<<<<< HEAD
			frame0.x = 20;
			addChild(frame0);
			frame1 = new SinglWin(10,110);
			frame1.x = 20;
=======
			addChild(frame0);
			frame1 = new SinglWin(10,70);
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
			addChild(frame1);
		}
	}
}