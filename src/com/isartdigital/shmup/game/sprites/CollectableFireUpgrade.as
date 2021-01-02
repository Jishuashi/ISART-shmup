package com.isartdigital.shmup.game.sprites 
{
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableFireUpgrade extends Collectable 
	{
		
		public function CollectableFireUpgrade(pAsset : String) 
		{
			super(pAsset);
		}
		
		override protected function doOnCollision():void 
		{
			Player.getInstance().weaponLevel += 1;
		}
		
	}

}