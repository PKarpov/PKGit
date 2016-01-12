package view 
{
	import flash.system.System;
	import model.CModel;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import view.items.Board;
	import view.items.Key;
	/**
	 * ...
	 * @author fish
	 */
	public class Calculator extends Sprite	{
		[Embed(source = "../../lib/consola.ttf", embedAsCFF = "false", fontFamily = "font00")]
		public static const font00:Class;

		private var keys:Vector.<Key> = new Vector.<Key>;
		private var board:Board;
		private const labels:String = '1470258C369=+-*/';
		
		public function Calculator() 	{
			addEventListener(Event.ADDED_TO_STAGE, buildCalculator);
		}
		
		private function buildCalculator(e:Event):void 	{
			removeEventListener(Event.ADDED_TO_STAGE, buildCalculator);
			stage.addEventListener(Event.RESIZE, onResize);
			var _labels:Array = labels.split('');
			var _key:Key;
			do {
				_key = new Key(_labels.shift());
				keys.push(_key);
				addChild(_key);
			}	while (_labels.length);
			board = new Board();
			addChild(board);
			//board.addEventListener(Board.MAX_SIZE, manager.setMaxSize);
			//logic.addEventListener(CModel.INPUT_ERROR, board.inputError);
			//logic.addEventListener(CModel.NEW_VALUE, board.newValue);

			newSizes(stage.stageWidth, stage.stageHeight);
		}
		
		private function onResize(e:ResizeEvent):void{
			newSizes(e.width, e.height);
		}
		
		private function newSizes(_W:int, _H:int):void {
			// вичисляем новые размеры
			var _width:int = _W / 5; 
			var _dd:int = (_W - _width * 4) / 5;// растояние между кнопками
			var _height:int = (_H - _dd * 6) / 5;
			var _size:int = Math.round((_width<_height? _width:_height)*.8);
			var _key:Key;
			var _i:int = 0;
			// меняем расположение кнопок
			for (var _col:int = 0; _col < 4; _col++ ) {
				for (var _row:int = 1; _row < 5; _row++ ) {
					//if (_col < 3 && _row == 0) continue;
					_key = keys[_i++];
					_key.x = _dd + (_width + _dd) * _col;
					_key.y = _dd + (_height + _dd) * _row;
					_key.chengeSize(_width, _height, _size);// меняем размер кнопки
				}
			}
			// меняем размеры и расположение табло
			board.chengeSize((_W - _dd * 2), _size, _size);
			board.x = board.y = _dd;
			trace("Memory=" + System.totalMemory);
		}
		
	}

}