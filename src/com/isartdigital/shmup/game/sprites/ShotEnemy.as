package com.isartdigital.shmup.game.sprites
{
	import com.adobe.tvsdk.mediacore.events.PlaybackRateEvent;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotEnemy extends StateObject
	{
		public static var list:Vector.<ShotEnemy> = new Vector.<ShotEnemy>();
		public var velocity:Point;
		private var enemyShotCollider:MovieClip;
		
		public function ShotEnemy(pAsset:String, pVelocity:Point)
		{
			assetName = pAsset;
			velocity = pVelocity;
			
			super();
			
			enemyShotCollider = MovieClip(getChildAt(1));
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
			
			doCollision(Player.getInstance());
			
			for (var j:int = Obstacle.list.length -1  ; j > -1; j--) 
			{
				doCollision(Obstacle.list[j]);
			}
			
			if (x < lXMin || x > lXMax || y < lYMin || y > lYMax)
			{
				destroy();
			}
		}
		
		private function doCollision(pTarget:StateObject):void
		{
			if (CollisionManager.hasCollision(hitBox, pTarget.hitBox, hitPoints))
			{
				doAction = doExplosion;
				if (!Player.invincible)
				{
					if (pTarget is Player)
					{
						pTarget.doAction = Player(pTarget).doActionHurt;
					}
				}
				
				if (pTarget is Obstacle2)
				{
					pTarget.doAction = Obstacle2(pTarget).doExplosion;
				}
			}
		}
		
		override public function get hitPoints():Vector.<Point>
		{
			var lPosHitPoints:Vector.<Point> = new Vector.<Point>();
			var lPosition:Point;
			var lChild:DisplayObject;
			
			for (var i:int = 0; i < 3; i++)
			{
				lChild = enemyShotCollider.getChildByName("mcHitPoint" + i);
				lPosition = enemyShotCollider.localToGlobal(new Point(lChild.x, lChild.y));
				lPosHitPoints.push(lPosition);
			}
			
			return lPosHitPoints;
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
	}
}