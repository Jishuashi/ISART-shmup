package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Boss extends Enemy 
	{
		public static var list:Vector.<Boss> = new Vector.<Boss>();
		
		public function Boss(pAsset : String) 
		{
			super(pAsset);
			assetName = pAsset;
		}
		
	}

}