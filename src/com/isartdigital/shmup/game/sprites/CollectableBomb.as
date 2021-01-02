package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.ui.hud.Hud;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableBomb extends Collectable
	{
		
		public function CollectableBomb(pAsset:String)
		{
			super(pAsset);
		
		}
		
		override protected function doOnCollision():void
		{
			if (Player.getInstance().nbOfBomb <= 2)
			{
				Player.getInstance().nbOfBomb += 1;
				Hud.getInstance().mcTopLeft.getChildByName("mcGuide" + (Player.getInstance().nbOfBomb - 1)).visible = true;
			}
		}
	
	}
}