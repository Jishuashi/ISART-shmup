package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Collectable extends StateObject 
	{
		public static var list : Vector.<Collectable> = new Vector.<Collectable>();
		
		public function Collectable(pAsset : String) 
		{
			assetName = pAsset;
			super();
			
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			doCollision();
		}
		
		protected function doOnCollision():void 
		{
			
		}
		
		
		protected function doCollision():void 
		{
			if (CollisionManager.hasCollision(hitBox , Player.getInstance().hitBox))
			{
				doOnCollision();
				destroy();
			}
		}
		
		override public function destroy():void 
		{
			list.removeAt(list.indexOf(this));
			super.destroy();
		}
		
	}

}