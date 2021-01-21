package utils.math
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
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
		
		/**
		 * transform coordinates the easy way;
		 * @param the object to get the coordinates from
		 * @param the object where those coordinates are transformed to
		 * @return return the coordinates of the first object in the new referential.
		 */
		public static function localToGlobalToLocal(pTarget:DisplayObject, pEndLocal:DisplayObject):Point
		{
			return pEndLocal.globalToLocal(pTarget.parent.localToGlobal(new Point(pTarget.x, pTarget.y)));
		}
		
		
		
		/**
		 * transform coordinates the easy way;
		 * @param the point of object to get the coordinates from
		 * @param the object where those coordinates are transformed from
		 * @param the object where those coordinates are transformed to
		 * @return return the coordinates of the first object in the new referential.
		 */
		public static function localToGlobalToLocalPoint(pPoint:Point , pStartLocal : DisplayObjectContainer, pEndLocal:DisplayObject):Point
		{
			return pEndLocal.globalToLocal(pStartLocal.localToGlobal(pPoint));
		}
	}

}