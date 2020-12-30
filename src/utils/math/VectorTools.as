package utils.math
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class VectorTools
	{
		
		public static function dotProduct(pA:Point, pB:Point):Number
		{
			return pA.x * pB.x + pA.y * pB.y;
		}
		
		public static function moveToward(pCurrent:Point, pTarget:Point, pSpeed:Number):Point
		{
			var lCurrentToTarget:Point = pTarget.subtract(pCurrent);
			lCurrentToTarget.normalize(pSpeed);
			return pCurrent.add(lCurrentToTarget);
		}
	
	}

}