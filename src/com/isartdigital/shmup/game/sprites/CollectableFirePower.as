package com.isartdigital.shmup.game.sprites 
{
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableFirePower extends Collectable 
	{
		
		public function CollectableFirePower(pAsset : String) 
		{
			super(pAsset);
		}
		
		override protected function doOnCollision():void 
		{
			Player.getInstance().weaponDamage = 2;
		}
	}

}