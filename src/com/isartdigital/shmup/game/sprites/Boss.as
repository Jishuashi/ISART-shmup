package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Boss extends Enemy 
	{
		public static var boss: Enemy;
		
		public function Boss(pAsset : String) 
		{
			super(pAsset);
			assetName = pAsset;
			scaleX = scaleY = 1;
		}
		
		
	}

}