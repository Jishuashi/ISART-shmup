package com.isartdigital.shmup.game.sprites 
{
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableShield extends Collectable 
	{
		
		public function CollectableShield(pAsset : String) 
		{
			super(pAsset);
		}
		
		override protected function doCollision():void 
		{
			Player.getInstance().doShield();
		}
		
	}

}