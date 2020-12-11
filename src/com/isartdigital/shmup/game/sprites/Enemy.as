package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.utils.game.StateObject;
	
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy extends StateObject 
	{
		public static var list:Vector.<Enemy> = new Vector.<Enemy>();
		
		public function Enemy(pAsset : String) 
		{
			assetName = pAsset;
			super();
			
			
		}
		
	}

}