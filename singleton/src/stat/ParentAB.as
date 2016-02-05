package stat 
{
	/**
	 * ...
	 * @author fish
	 */
	public class ParentAB 
	{
<<<<<<< HEAD
		private static var _aa:String = '123';
=======
		private static var _aa:String;
>>>>>>> 9878e0d079a355604bad3073ad97dc23ea560cc7
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