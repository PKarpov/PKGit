package singl
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
<<<<<<< HEAD
	import tools.Utils;
=======
	import Utils;
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
	public class Singleton extends Sprite
	{
		private static var _instance:Singleton;
		private var _alert:Sprite;
		private var _msg:TextField;
		
		private var _goChannel:SoundChannel;
		private var _tuneUp:Sound;
		
		private var _tm:Timer = new Timer(1200, 1);
		
		public static function getInstance():Singleton
		{
			if (_instance == null) 	{
				_instance = new Singleton ();
				_instance.initAlertWin();
			}
			return _instance;
		}
		
		private function initAlertWin():void 
		{
			_alert = Utils.drawNewAlert();
<<<<<<< HEAD
			_msg = TextField(_alert.getChildByName('msg'));
			_alert.x = 20;
			_alert.y = 140;
=======
			_msg = Utils.newTextField(0,5);
			_msg.width = 300;
            _msg.autoSize = TextFieldAutoSize.CENTER;
			_alert.addChild(_msg);
			_alert.x = 40;
			_alert.y = 100;
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
			_alert.visible = false;
			addChild(_alert);
			_tm.addEventListener(TimerEvent.TIMER, startDisappear)
		}
		
		private function startDisappear(e:Event):void 
		{
			addEventListener(Event.ENTER_FRAME, disappearAlert);
		}
		
		public function showAlert(ms:String):void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener (Event.ENTER_FRAME, disappearAlert);
			_msg.text = ms;
			_alert.alpha = 1;
			_alert.visible = true;
			_tm.reset();
			_tm.start();
		}
		
		public function playSound(song:String):void
		{
			if (_goChannel != null)	{
				_goChannel.stop ();
			}
			var _tuneIn:URLRequest=new URLRequest(song);
			_tuneUp=new Sound();
			_tuneUp.load(_tuneIn);
			_goChannel = _tuneUp.play();
			showAlert(song);
		}
		
		private function disappearAlert(e:Event):void 
		{
			_alert.alpha -= .1;
			if (_alert.alpha <= 0) {
				_alert.visible = false;
				removeEventListener(Event.ENTER_FRAME, disappearAlert);
			}
		}
	}
}
