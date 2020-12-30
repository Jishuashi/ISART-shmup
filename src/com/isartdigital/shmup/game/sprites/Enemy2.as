package com.isartdigital.shmup.game.sprites 
{
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy2 extends Enemy 
	{
		
		public function Enemy2(pAsset:String) 
		{
			super(pAsset);
			nbOfCanon = 6;
			nbOfLife = 6;
			scoreValue = 1000;
		}
		
	}

}