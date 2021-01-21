package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.ui.hud.Hud;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableLife extends Collectable
	{
		
		public function CollectableLife(pAsset:String)
		{
			super(pAsset);
			onlist = true;
		}
		
		override protected function doOnCollision():void
		{
			if (Player.getInstance().life <= 2)
			{
				Player.getInstance().life++;
				Hud.getInstance().mcTopRight.getChildByName("mcGuide" + (Player.getInstance().life - 1)).visible = true;
			}
		}
	}

}