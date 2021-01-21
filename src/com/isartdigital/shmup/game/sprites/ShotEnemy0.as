package com.isartdigital.shmup.game.sprites 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotEnemy0 extends ShotEnemy 
	{
		
		public function ShotEnemy0(pAsset:String, pVelocity:Point) 
		{
			super(pAsset, pVelocity);
			
		}
		
		
		override protected function move():void 
		{
			super.move();
			
			
			x += velocity.x;
			y += velocity.y;
			
			
		}
	}

}