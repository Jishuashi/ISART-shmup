package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableShield extends Collectable
	{
		
		public function CollectableShield(pAsset:String)
		{
			super(pAsset);
			onlist = true;
		}
		
		override protected function doOnCollision():void
		{
			
			if (!Shield.shieldOn)
			{
				GameManager.shield = new Shield("Shield");
				
				GameManager.shield.x = Player.getInstance().x;
				GameManager.shield.y = Player.getInstance().y;
				
				GameManager.shield.start();
				
				Shield.shieldOn = true;
				
				GameLayer.getInstance().addChild(GameManager.shield);
			}
		}
	
	}

}