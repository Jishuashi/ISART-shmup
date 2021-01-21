package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotAlly extends StateObject 
	{
		public static const SHOT_SPEED:int = 22;
		
		public static var list:Vector.<ShotAlly> = new Vector.<ShotAlly>();
		public static var shotVelocities:Vector.<Point> = new <Point>[];
	
		
		public var shotCollider:MovieClip;
		public var velocity:Point;
		
		public function ShotAlly(pAsset:String, pVelocity:Point)
		{
			assetName = pAsset;
			velocity = pVelocity;
			super();
			
			scaleX *= -1;
			
			shotCollider = MovieClip(getChildAt(1));
		}
		
		override protected function doActionNormal():void
		{
			super.doActionNormal();
			
			var lScreenLimits : Rectangle = GameLayer.getInstance().screenLimits;
			
			var lXMax:Number = lScreenLimits.right;
			var lXMin:Number = lScreenLimits.left;
			var lYMax:Number = lScreenLimits.bottom;
			var lYMin:Number = lScreenLimits.top;
			
			x -= velocity.x;
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
			if (CollisionManager.hasCollision(hitBox, pTarget.hitBox , hitPoints))
			{
				if (pTarget is Enemy && !Enemy(pTarget).allyModeOn)
				{
					Enemy(pTarget).doDestroy();
					doAction = doExplosion;
				}
				
				if (pTarget is Obstacle2)
				{
					pTarget.doAction = Obstacle2(pTarget).doExplosion;
					doAction = doExplosion;
				}
				
				if (pTarget is Boss)
				{
					//pTarget.doAction = Boss(pTarget).doActionHurtBoss;
					//doAction = doExplosion;
				}
				
				
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