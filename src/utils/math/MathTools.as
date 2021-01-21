package utils.math
{
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class MathTools
	{
		public static var DEG2RAD:Number = Math.PI / 180;
		public static var RAD2DEG:Number = 180 / Math.PI;
		
		public static function lerp(pStart:Number, pEnd:Number, pRatio:Number):Number
		{
			return pStart + (pEnd - pStart) * pRatio;
		}
	
	}

}