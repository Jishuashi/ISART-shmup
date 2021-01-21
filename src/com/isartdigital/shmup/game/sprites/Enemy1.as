package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import flash.geom.Point;
	import utils.math.VectorTools;
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy1 extends Enemy
	{
	
		private var speed : int = 0.5;
		
		
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
			
			y = Player.getInstance().y;
			
		}
		
	}

}