package 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author fish
	 */
	public class Utils 
	{
		private static var _format:TextFormat = new TextFormat('Verdana', 12, 0x660033);
		
		static public function newTextField(_x:int=0, _y:int=0, tx:String = ''):TextField {
			var txt:TextField = new TextField();
			txt.x = _x;
            txt.y = _y;
            txt.autoSize = TextFieldAutoSize.LEFT;
			txt.defaultTextFormat = _format;
			txt.text = tx;
			return txt;
		}
		
		static public function drawNewLine(p0:Point, p1:Point, thick:int = 0, color:uint = 0x660033):Sprite {
			var line:Sprite = new Sprite;
			line.graphics.lineStyle(thick, color);
			line.graphics.moveTo(p0.x, p0.y);
			line.graphics.lineTo(p1.x, p1.y);
			return line;
		}
		
		static public function drawNewRect(w:int, h:int, color:uint = 0xffcc44):Sprite {
			var rect:Sprite = new Sprite;
			rect.graphics.beginFill(0xffcc44);
			rect.graphics.drawRect(0, 0, w, h);
			return rect;
		}
		
		static public function get format():TextFormat 
		{
			return _format;
		}

		
	}

}