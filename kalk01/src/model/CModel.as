package model 
{
	//import com.creativebottle.starlingmvc.beans.BeanProvider;
	import controller.events.CalculatorEvent;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author fish
	 */
	public class CModel
	{
		private var num0:Number = 0;
		private var prev_key:String = '' ;// тип предыдущей нажатой кнопки [C,=,num,act]
		public var board:String = '0'; // строка для индикатора
		//private var limit:int; // максимальное количество символов которое влезет в поле индикатора
		private var act:String = ''; // символ текущей операции
		
		public function CModel()	{
			trace("MODEL IS CREATED");
		}
		
		[EventHandler(event="DISPLAY_BUG")]
		public function displayBug (e:CalculatorEvent):void	{ 
			board = '0';
			act = '';
			prev_key = 'C';
		}
		
		[EventHandler(event="BUTTON_PRESSED")]
		public function Compute (e:CalculatorEvent):void	{ // реагируем на ввод информации
			//trace(e.info)
			var _sign:String = e.info;
			var _type:String = typeKey(_sign) ;
			trace(_sign+'  '+_type);
			if (_type == 'C') {// кнопка очистить
				if (board == '0' && act == '') return;
				if (board != '0' && act != '' && prev_key == 'num') {
					board = String(num0) + act;
				} else if (board != '0' && act != '' && (prev_key == 'C' || prev_key == 'act')) {
					act = '';
					num0 = 0;
					board = String(num0);
				}	else board = ('0');
			} else	if (_type == 'num') {// нажата цифра
				if (board == '0' && _sign == '0') return;
				if (prev_key != 'num' || board == '0'){
					board = _sign;
				} else board = board+_sign;
			} else if (_sign == '=') {// кнопка вычислить 
				if (act == '' || board == '0' || num0 == 0 || prev_key == 'act') return;
				board = (calculate());
			} else { // нажата кнопка операции
				if (board == '0') return;
				if (act == '') {
					num0 = Number(board);
					board = board +_sign;
				} else if (prev_key == 'act'||(prev_key == 'C' && act != '')) {
					board = String(num0)+_sign;
				} else {
					board = calculate()+_sign;
				}
				act = _sign;
			}
			prev_key = _type;
			function calculate():Number{
				var _num:Number = Number(board);	
				var _result:Number;
				switch (act) {
					case '+': 
						_result = num0 + _num;
						break;
					case '-': 
						_result = num0 - _num;
						break;
					case '*': 
						_result = num0 * _num;
						break;
					case '/': 
						_result = num0 / _num;
						break;
				}
				act = '';
				_result = Math.round(_result * 100) / 100;
				num0 = _result;
				return _result;
			}
		}
		
		private function typeKey (_s:String):String { // определяем тип нажатой кнопки
			//возможные варианты типов [C^=^num^act] 
			var _type:String;
			if (_s == 'C' || _s == '='){
				_type = _s;
			} else if (_s == '+' || _s == '-' || _s == '*' || _s == '/') {
				_type = 'act';
			} else _type = 'num';
			return _type;
		}
	}
}