package view.items 
{
	import controller.events.CalculatorEvent;
	import flash.geom.Matrix3D;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author fish
	 */
	public class Key extends Sprite {
		public	var sign:String; 
		private	var label:TextField;
		
		private	var key_cover:Sprite;
		private	var key_pad:Sprite;
		private var border:int;
		static public const PRESS_KEY:String = 'PRESS_KEY';
		
		public function Key( ss:String, borderColor:uint = 0x990000, plainColor:uint = 0xFF7700, borderThickness:int = 2) {
			// рисуем заготовку кнопки
			var _w:int = 100;
			key_pad = new Sprite;
			var quad:Quad = new Quad(_w , _w, borderColor);
			key_pad.addChild(quad);
			key_cover = new Sprite;
			quad = new Quad(_w, _w,0xffcc77);
			quad.setVertexColor(3, plainColor);
			key_cover.addChild(quad);
			border = key_cover.x = key_cover.y = borderThickness;
			addChild(key_pad);
			addChild(key_cover);
			// рисуем лэйбу кнопки 
			sign = ss;
			var _size:int = Math.round(_w);
			label = new TextField(_w, _w, sign, "font00", _size, sign == 'C'?0xff0000:borderColor);
			//label.y = Math.round((_w - label.height) / 2);
			addChild(label);
			filter = BlurFilter.createDropShadow(4, .785, 0, .7, 3, 1);
			addEventListener(TouchEvent.TOUCH, pressKey);
		}
		 		
		private function pressKey(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (!touch) return;
			var _key:Key = e.currentTarget as Key;
			if (touch.phase == TouchPhase.BEGAN) {
					filter.dispose();
					dispatchEvent(new CalculatorEvent(CalculatorEvent.BUTTON_PRESSED, sign));
				} else if (touch.phase == TouchPhase.ENDED) {
					filter = BlurFilter.createDropShadow(4, .785, 0, .7, 3, 1);
				}
		}

		public function chengeSize (_w:int, _h:int, _size:int):void {
			label.fontSize = _size;
			label.width = _w;
			label.height = _h;
			//label.y = Math.round(_size/10);
			key_pad.width = _w;
			key_pad.height = _h;
			key_cover.width = _w - border*2 ;
			key_cover.height = _h - border*2 ;
		}
	}

}