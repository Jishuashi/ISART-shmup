package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotPlayer extends StateObject
	{
		
		public static var shotList : Vector.<Sprite> = new Vector.<Sprite>();
		public static var shotVelocities:Vector.<Point> = new <Point>[];
		public static const SHOT_SPEED:int = 22;
		
		
		public function ShotPlayer(pAsset : String) 
		{
			assetName = pAsset;
			super();
		}
		
		public static function doActionNormalShot():void 
		{
			var lShot:Sprite;
			var lVelocity: Point;
			var lXMax:Number = Config.stage.stageWidth;
			var lXMin:Number = -Config.stage.stageWidth;
			var lYMax:Number = Config.stage.stageHeight;
			var lYMin:Number = -Config.stage.stageHeight;
			
			for (var i:int = shotList.length - 1; i > -1; i--)
			{
				lShot = shotList[i];
				lVelocity = shotVelocities[i];
				
				lShot.x += lVelocity.x;
				lShot.y += lVelocity.y;
				
				if (lShot.x < lXMin || lShot.x > lXMax || lShot.y < lYMin || lShot.y > lYMax)
				{
					destroyShot(i);
					continue;
				}
			}	
		}
		
		
		public static function destroyShot(pIndex:uint):void
		{
			Config.stage.removeChild(shotList[pIndex]);
			shotList.removeAt(pIndex);
			shotVelocities.removeAt(pIndex);
		}
		
		public static function doDestroyAllShots():void
		{
			for (var i:int = shotList.length - 1; i > -1; i--)
			{
				destroyShot(i);
			}
		}
		
	}

}