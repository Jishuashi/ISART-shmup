package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Shield extends StateObject 
	{
		public function Shield(pAsset :String) 
		{
			assetName = pAsset;
			super();
		}
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			
			
			
		}
		
		public function doExplosion():void 
		{
			setState("explosion")
			
			if(isAnimEnd())
			{
				trace ("")
				setState("default")
				destroy();
			}
		}

	}
}