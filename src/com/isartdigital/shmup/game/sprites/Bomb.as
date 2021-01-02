package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Bomb extends StateObject
	{
		public static var bomb : Bomb = new Bomb("Bomb");
		private var instanceGameLayer : GameLayer = GameLayer.getInstance();
		
		public function Bomb(pAsset:String)
		{
			assetName = pAsset;
			super();
			
			scaleY = scaleX = 2;
		
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			x -= instanceGameLayer.speed;
			
			if(isAnimEnd())
			{
				trace("Trace")
				
				for (var i:int = ShotEnemy.list.length - 1; i > -1; i--)
				{
					ShotEnemy.list[i].doExplosion();
				}
				
				for (var j:int = ShotPlayer.list.length - 1; j > -1; j--)
				{
					ShotPlayer.list[j].doExplosion();
				}
				
				for (var k:int = Enemy.list.length - 1; k > -1; k--)
				{
					Enemy.list[k].nbOfLife = 0;
					Enemy.list[k].doDestroy();
				}
				
				for (var l:int = Obstacle.list.length -1; l > -1; l--) 
				{
					if (Obstacle.list[l] is Obstacle2)
					{
						Obstacle2(Obstacle.list[l]).doExplosion();
					}
				}
				
				Player.getInstance().bombOn = false;
				
				doAction = doActionNormal;
				bomb.destroy();
			}
			
		}
		
		public function spawnBomb():void
		{
			bomb.start();
			
			bomb.x = instanceGameLayer.screenLimits.right - instanceGameLayer.screenLimits.width / 2;
			bomb.y = instanceGameLayer.screenLimits.bottom - instanceGameLayer.screenLimits.height / 2 ;
			
			GameLayer.getInstance().addChild(bomb);
			bomb.setState("default");
		}
	}

}