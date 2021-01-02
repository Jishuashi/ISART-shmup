package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotBoss extends StateObject
	{
		public static var list:Vector.<ShotBoss> = new Vector.<ShotBoss>();
		private var velocity:Point;
		
		public function ShotBoss(pAsset:String, pVelocity:Point)
		{
			velocity = pVelocity;
			assetName = pAsset;
			
			super();
		}
		
		override protected function doActionNormal():void
		{
			super.doActionNormal();
			
			var lXMax:Number = GameLayer.getInstance().screenLimits.right;
			var lXMin:Number = GameLayer.getInstance().screenLimits.left;
			var lYMax:Number = GameLayer.getInstance().screenLimits.bottom;
			var lYMin:Number = GameLayer.getInstance().screenLimits.top;
			
			x += velocity.x;
			y += velocity.y;
			
			//doCollision(Player.getInstance());
			
			if (x < lXMin || x > lXMax || y < lYMin || y > lYMax)
			{
				destroy();
			}
		}
		
		public function doExplosion():void
		{
			setState("explosion");
			
			if (isAnimEnd())
			{
				destroy();
			}
		}
		
		override public function destroy():void
		{
			list.removeAt(list.indexOf(this));
			super.destroy();
		}
		
		private function doCollision(pTarget:StateObject):void
		{
			doAction = doExplosion;
			if (!Player.invincible)
			{
				if (pTarget is Player)
				{
					pTarget.doAction = Player(pTarget).doActionHurt;
				}
			}
		}
	
	}

}