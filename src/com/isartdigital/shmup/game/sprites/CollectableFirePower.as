package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.levelDesign.CollectableGenerator;
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
		
		override public function destroy():void 
		{
			CollectableGenerator.listOfCollectablesGenerate.removeAt(CollectableGenerator.listOfCollectablesGenerate.indexOf(this));
			super.destroy();
		}
	}

}