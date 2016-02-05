package singl 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
<<<<<<< HEAD
	import tools.Utils;
=======
	import MyButton;
	//import tools.Utils;
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
	
	/**
	 * ...
	 * @author fish
	 */
	public class SinglWin extends Sprite 
	{
		private var s0:Singleton;
		private var s1:Singleton;
		private var Button0:MyButton;
		private var Button1:MyButton;
		private var Button2:MyButton;
		private var Button3:MyButton;
		private var Text1:TextField;

		public function SinglWin(_x:int=0,_y:int=20) 
		{
			x = _x;
			addChild(Utils.newTextField(0, (_y-10), 'SingleTon'));
			addChild(Utils.drawNewLine(new Point(110, _y), new Point(310, _y)));
			_y += 30;
<<<<<<< HEAD
			Button0 = new MyButton('Все отлично!!!', 'Alert1', 50, _y);
			Button1 = new MyButton('Полный писец!', 'Alert2', 130, _y);
			Button2 = new MyButton('../sound/song2.mp3', 'Song1', 230, _y);
			Button3 = new MyButton('../sound/song3.mp3', 'Song2', 310, _y);
=======
			Button0 = new MyButton('Все отлично!!!', 'Alert1', 60, _y);
			Button1 = new MyButton('Полный писец!', 'Alert2', 140, _y);
			Button2 = new MyButton('../sound/song2.mp3', 'Song1', 240, _y);
			Button3 = new MyButton('../sound/song3.mp3', 'Song2', 320, _y);
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
			addChild(Button0);
			addChild(Button1);
			addChild(Button2);
			addChild(Button3);
			Button0.addEventListener(MouseEvent.CLICK, mouseClick0123);
			Button1.addEventListener(MouseEvent.CLICK, mouseClick0123);
			Button2.addEventListener(MouseEvent.CLICK, mouseClick0123);
			Button3.addEventListener(MouseEvent.CLICK, mouseClick0123);
			s0 = Singleton.getInstance();
			s1 = Singleton.getInstance();
			addChild(s0);
			s0.y = 40;
			addChild(s1);
			s1.y = 20;
			trace (s0.y);// s0===s1 это один и тот-же объект
		}
		private function mouseClick0123(e:Event):void
		{
			switch(e.currentTarget){
				case Button0:
					s0.showAlert(e.currentTarget.id);
					break;
				case Button1:
					s1.showAlert(e.currentTarget.id);
					break;
				case Button2:
					s0.playSound(e.currentTarget.id);
					break;
				case Button3:
					s1.playSound(e.currentTarget.id);
					break;
			}
		}
		
	}

}