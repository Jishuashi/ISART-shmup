package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotPlayer extends StateObject
	{
		
		public static var list:Vector.<ShotPlayer> = new Vector.<ShotPlayer>();
		public static var shotVelocities:Vector.<Point> = new <Point>[];
		public static const SHOT_SPEED:int = 22;
		public var shotCollider:MovieClip;
		public var velocity:Point;
		
		public function ShotPlayer(pAsset:String, pVelocity:Point)
		{
			assetName = pAsset;
			velocity = pVelocity;
			super();
			
			shotCollider = MovieClip(getChildAt(1));
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
			
			for (var i:int = Enemy.list.length - 1; i > -1; i--)
			{
				doCollision(Enemy.list[i]);
			}
			
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
			if (CollisionManager.hasCollision(hitBox, pTarget, hitPoints))
			{
				if (pTarget is Enemy)
				{
					Enemy(pTarget).doDestroy();
				}
				
				if (pTarget is Obstacle2)
				{
					pTarget.doAction = Obstacle2(pTarget).doExplosion;
				}
				
				doAction = doExplosion;
			}
		}
		
		private function doExplosion():void
		{
			setState("explosion");
			
			if (isAnimEnd())
			{
				destroy();
			}
		}
		
		override public function get hitPoints():Vector.<Point>
		{
			var lPosHitPoints:Vector.<Point> = new Vector.<Point>();
			var lPosition:Point;
			var lChild:DisplayObject;
			
			for (var i:int = 0; i < 1; i++)
			{
				lChild = shotCollider.getChildByName("mcHitPoint" + i);
				lPosition = shotCollider.localToGlobal(new Point(lChild.x, lChild.y));
				lPosHitPoints.push(lPosition);
			}
			
			return lPosHitPoints;
		}
		
		override public function destroy():void
		{
			list.removeAt(list.indexOf(this));
			super.destroy();
		}
	
	}

}