package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy1 extends Enemy
	{
		
		public function Enemy1(pAsset : String) 
		{
			super(pAsset);
			nbOfCanon = 3;
			nbOfLife = 15;
			
			indexOfShot = 1;
			
			waitingTime = 60;
			
			scoreValue = 300;
			canGenerateItems = true;
		}
		
		override protected function move():void 
		{
			super.move();
			
			doDestroyOutsideOfscreen();
			
			y = Player.getInstance().y - 20;
		}
		
	}

}