package stat 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import MyButton;
	//import tools.Utils;
	
	/**
	 * ...
	 * @author fish
	 */
	public class StatWin extends Sprite 
	{
		private var Button0:MyButton;
		private var Button1:MyButton;
		private var Button2:MyButton;
		private var Text0:TextField;
		private var Text1:TextField;
		private var obj0:NewClassA;
		private var obj1:NewClassB;

		public function StatWin(_x:int=0, _y:int=0) 
		{
			x = _x;
			addChild(Utils.newTextField(0, (_y-10), 'TestStaticVar'));
			addChild(Utils.drawNewLine(new Point(110, _y), new Point(310, _y)));
			_y += 20;
			Text0 = Utils.newTextField(110, _y);
			Text1 = Utils.newTextField(310, _y);
			_y += 10;
			Button0 = new MyButton('2', 'NewStatVar', 60, (_y));
			Button1 = new MyButton('0', 'ClassA', 180, _y);
			Button2 = new MyButton('1', 'ClassB', 260, _y);
			addChild(Button0);
			addChild(Text0);
			addChild(Text1);
			_y += 40;
			addChild(Button1);
			addChild(Button2);
			Button0.addEventListener(MouseEvent.CLICK, mouseClick0);
			Button1.addEventListener(MouseEvent.CLICK, mouseClick12);
			Button2.addEventListener(MouseEvent.CLICK, mouseClick12);
			obj0 = new NewClassA('ClassA');
			obj1 = new NewClassB('ClassB');
			mouseClick0(null);
		}
		
		private function mouseClick12(e:Event):void 
		{
			switch(e.currentTarget){
				case Button1:
					Text1.text = obj0.getStaticVar();
					break;
				case Button2:
					Text1.text = obj1.getStaticVar();
					break;
			}
			//obj0.test();
		}
		
		private function mouseClick0(e:Event):void
		{
			var n:String = String(Math.round(Math.random() * 100));
			Text0.text = n;
			ParentAB.aa = n;
		}
	}

}