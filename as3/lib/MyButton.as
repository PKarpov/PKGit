package {
	public class MyButton extends ButtonDis {
		public var id:String;
		public function MyButton(id:String = 'ID', text:String = 'Press here', _x:int = 0, _y:int = 0) {
			this.id = id;
			label_txt.text = text;
			label_txt.mouseEnabled = false;
			x = _x;
			y = _y;
		}
	}
}
