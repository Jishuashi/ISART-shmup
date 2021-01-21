package com.isartdigital.shmup.game.sprites 
{
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Obstacle2 extends Obstacle 
	{
	
		public var onDestroy :Boolean = false;
		
		public function Obstacle2(pAsset:String) 
		{
			super(pAsset);
			
		}
		
		
		public function  doExplosion():void 
		{
			setState("explosion")
			
			
			if(isAnimEnd())
			{
				
				onDestroy = true;
				
				destroy();
				doAction = doActionVoid;
			}
		}
		
		override public function destroy():void 
		{
			list.removeAt(list.indexOf(this));
			super.destroy();
		}
	}

}