package com.isartdigital.shmup.game.sprites
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotEnemy2 extends ShotEnemy
	{
			
		public function ShotEnemy2(pAsset:String, pVelocity:Point, pTarget:Enemy)
		{
			super(pAsset, pVelocity);
			targetEnemy = pTarget;
		}
		
		override protected function move():void
		{
			super.move();
			
			if (Enemy2(targetEnemy).returnRotation)
			{
				x -= velocity.x;
				y += velocity.y;
			}
			else
			{
				x += velocity.x;
				y += velocity.y;
			}
		}
	}

}