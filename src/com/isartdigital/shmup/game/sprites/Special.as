package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Special extends StateObject 
	{
		public static const SPEED_SPE : int = 25;
		private var velocity : Point;
		private var specialCollider: MovieClip;
		private var nbOfUse : int = 2;
		private var duration : int = 0;
		private var range : RangeAlly;
		
		public function Special(pAsset : String , pVelocity : Point) 
		{
			assetName = pAsset;
			velocity = pVelocity;
			super();
			
			specialCollider = MovieClip(getChildAt(1));
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
			
			
			if (x < lXMin || x > lXMax || y < lYMin || y > lYMax)
			{
				destroy();
			}
		}
		
		
		public function doCollision(pTarget : StateObject):void 
		{
			if (CollisionManager.hasCollision(hitBox , pTarget.hitBox , hitPoints))
			{
				if (pTarget is Enemy0 && !Enemy(pTarget).allyModeOn && Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x > Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x - GameManager.fullBar + 50 )
				{
					pTarget.doAction = Enemy0(pTarget).setModeAlly;
					Enemy(pTarget).allyModeOn = true;
					range = new RangeAlly();
					pTarget.addChild(range);
					
					Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x -= GameManager.fullBar / 2 + 25;
				}
				else if (pTarget is Enemy1 && !Enemy(pTarget).allyModeOn && Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x == 5)
				{
					pTarget.doAction = Enemy1(pTarget).setModeAlly;
					Enemy(pTarget).allyModeOn = true;
					range = new RangeAlly();
					pTarget.addChild(range);
					
					Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x -= GameManager.fullBar + 50 ;
				}
				else if (pTarget is Enemy2)
				{
					destroy();
				}
				else 
				{
					destroy();
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
				lChild = specialCollider.getChildByName("mcHitPoint" + i);
				lPosition = specialCollider.localToGlobal(new Point(lChild.x, lChild.y));
				lPosHitPoints.push(lPosition);
			}
			
			return lPosHitPoints;
		}
		
	}

}