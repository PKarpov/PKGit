package classes.design 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author fish
	 */
	public class Design extends Sprite 	{
		public static const x0:int = 75;
		public static const y0:int = 80;
		public static const num_columns:uint = 8;
		public static const num_rows:uint = 8;
		public static const num_types:int = 5; //number types of balls
		public static const counter_x:int = 440;//расположение счетчика
		public static const counter_y:int = 40; 
		public static const speed1:int = 30; 
		public static const speed2:int = 90; 
		public static const add_step:int = 3; 
		protected var counter0:TextField;
		protected var counter1:TextField;
		protected var counter2:TextField; 
		protected var score:int;
		protected var nn:int;
		
		[Embed(source="../../../img/bg.png")]
		private static var bg:Class;

		[Embed(source="../../../img/atlas.png")]
		private static var GeneralSheetClass:Class;

		[Embed(source = "../../../img/atlas.xml", mimeType = "application/octet-stream")]
		private static var GeneralAtlasClass:Class;
		
		[Embed(source="../../../img/impact.ttf", embedAsCFF="false", fontFamily="Impact")]
		private static const Impact:Class;


		public static var images:Vector.<Texture> = new Vector.<Texture>();
		public static const id_colors:Vector.<uint> = Vector.<uint>([0xff19ef, 0xfe0c0d, 0x106e11, 0x0F3ECF, 0xFE9D0D]);
		public static const CREATE_ALL_TEXTURE:String = "CREATE_ALL_TEXTURE"; 
		
		protected var button1:Button;
		protected var button2:Button;
		
		protected var screen0:Sprite;
		protected var screen1:Sprite;
		protected var screen2:Sprite;

		public static const dxy:uint = 50;
		public static const CLICK_ON_BUTTON:String = "CLICK_ON_BUTTON"; 

		public function Design() {
			var img:Image;
			var general_sheet:TextureAtlas;
			general_sheet = new TextureAtlas(Texture.fromBitmap(new GeneralSheetClass()), XML(new GeneralAtlasClass()));
			var texture:Texture; 
			for (var _i:int=0; _i < 8;_i++ ){
				texture = general_sheet.getTexture("i0" + _i);
				images.push(texture);
			}
			screen0 = new Sprite;
			screen1 = new Sprite;
			screen2 = new Sprite;
//~~~~~~~~~~~~~~	screen0	~~~~~~~~~~	
			img = new Image(images[7]);// название
			img.x = 80;
			img.y = 180;
			screen0.addChild(img);
			button1 = new Button(images[5]);// кнопа начать игру
			button1.x = 180;
			button1.y = 300;
			screen0.addChild(button1);
//~~~~~~~~~~~~~~	screen1	~~~~~~~~~~	
			var background:Texture = Texture.fromBitmap(new bg());
			img = new Image(background);// фон
			img.y = 24;
			screen1.addChild(img);
			counter0 = new TextField(20, 16, "");
			counter1 = new TextField(100, 30, "Счет:", "Impact", 24, 0x00CCFF);
			counter1.x = 340; 
			screen1.addChild(counter1);
			counter1 = new TextField(100, 30, "123", "Impact", 24, 0x00CCFF);
			counter1.x = 400; 
			screen1.addChild(counter0);
			screen1.addChild(counter1);
//~~~~~~~~~~~~~~	screen2	~~~~~~~~~~	
			counter2 = new TextField(300, 50, "Ваш результат:", "Impact", 40, 0x00CCFF);
			counter2.x = 70; 
			counter2.y = 200;
			screen2.addChild(counter2);
			counter2 = new TextField(100, 50, "123", "Impact", 40, 0x00CCFF);
			counter2.x = 350; 
			counter2.y = 200; 
			screen2.addChild(counter2);
			button2 = new Button(images[6]);// кнопа играть еще
			button2.x = 180;
			button2.y = 300;
			screen2.addChild(button2);
			button2.addEventListener(TouchEvent.TOUCH, touchHendler);
			button1.addEventListener(TouchEvent.TOUCH, touchHendler);
			addChild(screen0);
			addChild(screen1);
			addChild(screen2);
			manageScreens(0);
			addEventListener(EnterFrameEvent.ENTER_FRAME, frameRateCounter);
		}
		
		private function frameRateCounter(e:EnterFrameEvent):void {
			if (++nn>30){
				nn = 0;
				counter0.text = String(Math.round(1 / e.passedTime));
			}
		}
		
		private function touchHendler(e:TouchEvent):void		{
			var touch:Touch = e.getTouch(this);
			if (!touch) return;
			if (touch.phase == 'began') {
				dispatchEventWith(Design.CLICK_ON_BUTTON);	
				manageScreens(1);
			}
		}
		
		public function setCounter1 (_score:int, _color:uint):void	{
			score += _score;
			counter1.text = String(score);
			if (counter1.color != _color){
				counter1.color = _color;
			}
		}

		public function endGame ():void	{
			counter2.text = String(score);
			manageScreens(2);
		}
				
		public function manageScreens (_n:int):void {
			screen0.visible = _n == 0;
			screen1.visible = _n == 1;
			screen2.visible = _n == 2;
			score = 0;
			counter1.text = '0';
		}
	}

}