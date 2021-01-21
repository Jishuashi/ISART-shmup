package com.isartdigital.shmup.game.sprites 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotPlayer0 extends ShotPlayer 
	{
		
		public function ShotPlayer0(pAsset:String, pVelocity:Point) 
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