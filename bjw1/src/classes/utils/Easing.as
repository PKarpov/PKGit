package classes.utils {
//	"Cos","Quad","Cubic","Quart","Quint","Expo","Circ"		

	public final class Easing {
		static public function Cos010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t = (1-Math.cos(Math.PI * _i/_step))/2;
				trans.push((_x0+_xx*_t),(_y0+_yy*_t))
			}
			return trans;
		}
		
		static public function Quad010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					_t *=_t;
					trans.push((_x0+_xx/2*_t),(_y0+_yy/2*_t))
				} else {
					_t--;
					_t =_t*(_t-2)-1;
					trans.push((_x0-_xx/2*_t),(_y0 - _yy/2 *_t));
				}
			}
			return trans;
		}
		static public function Cubic010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					_t = _t*_t*_t;
					trans.push((_x0 + _xx/2 * _t),(_y0 +_yy/2 * _t))
				} else {
					_t-=2;
					_t = _t*_t*_t+2;
					trans.push((_x0 + _xx/2 * _t),(_y0 + _yy/2 *_t));
				}
			}
			return trans;
		}
		static public function Quart010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					_t = _t *_t* _t* _t
					trans.push((_x0 + _xx/2 * _t),(_y0 + _yy/2 * _t))
				} else {
					_t -= 2;
					_t = _t *_t* _t* _t - 2;
					trans.push((_x0 - _xx/2 * _t),(_y0 - _yy/2 *_t));
				}
			}
			return trans;
		}
		static public function Quint010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					_t = _t *_t * _t * _t * _t
					trans.push((_x0 + _xx/2 * _t),(_y0 + _yy/2 * _t))
				} else {
					_t-=2;
					_t = _t *_t * _t * _t * _t +2;
					trans.push((_x0 + _xx/2 * _t),(_y0 + _yy/2 * _t));
				}
			}
			return trans;
		}
		static public function Expo010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					--_t;
					trans.push((_x0 + _xx/2 * Math.pow(2, 10 * _t)),(_y0 + _yy/2 * Math.pow(2, 10 * _t)))
				} else {
					_t = 2 - Math.pow(2, -10 * --_t);
					trans.push((_x0 + _xx/2 * _t),(_y0 + _yy/2 * _t));
				}
			}
			return trans;
		}
		static public function Circ010 (_x0:int,_y0:int,_xx:int,_yy:int,_step:int=50):Vector.<int > {
			var _i:int;
			var _t:Number;
			var trans:Vector.<int > = new Vector.<int >;
			_xx -= _x0;
			_yy -= _y0;
			for (_i=1;_i<=_step;++_i) {
				_t =_i/_step*2;
				if (_t < 1) {
					_t = Math.sqrt(1-_t*_t)-1;
					trans.push((_x0-_xx/2*_t),(_y0-_yy/2*_t))
				} else {
					_t-=2;
					_t = Math.sqrt(1-_t*_t)+1;
					trans.push((_x0+_xx/2*_t),(_y0+_yy/2*_t));
				}
			}
			return trans;
		}
	}
}