package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.levelDesign.CollectableGenerator;
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
		
		override public function destroy():void 
		{
			CollectableGenerator.listOfCollectablesGenerate.removeAt(CollectableGenerator.listOfCollectablesGenerate.indexOf(this));
			super.destroy();
		}
	}

}