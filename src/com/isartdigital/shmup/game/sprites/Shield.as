package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Shield extends StateObject
	{
		
		private var counterFrame:int = 0;
		private var waitingTime:int = 250;
		public static var shieldOn : Boolean = false;
		
		public function Shield(pAsset : String)
		{
			assetName = pAsset;
			super();
		}
		
		override protected function doActionNormal():void
		{
			super.doActionNormal();
			
			x = Player.getInstance().x;
			y = Player.getInstance().y;
			
			if (counterFrame++ >= waitingTime)
			{
				doAction = doExplosion;
			}
		
		}
		
		public function doExplosion():void
		{
			setState("explosion")
			
			if (isAnimEnd())
			{
				counterFrame = 0;
				shieldOn = false;
				destroy();
				
			}
		}
	
	}
}