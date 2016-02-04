package stat 
{
	/**
	 * ...
	 * @author fish
	 */
	public class ParentAB 
	{
		private static var _aa:String;
		protected var _nm:String;
		
		static public function set aa(value:String):void 
		{
			_aa = value;
		}
		
		public function getStaticVar():String 
		{
			return _nm + ' var _aa='+_aa;
		}
	}

}