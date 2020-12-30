package com.isartdigital.shmup.game.levelDesign
{
	
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.sprites.Boss;
	import com.isartdigital.shmup.game.sprites.Enemy;
	import com.isartdigital.shmup.game.sprites.Enemy0;
	import com.isartdigital.shmup.game.sprites.Enemy1;
	import com.isartdigital.shmup.game.sprites.Enemy2;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe qui permet de générer des classes d'ennemis
	 * TODO: S'inspirer de la classe ObstacleGenerator pour le développement
	 * @author Mathieu ANTHOINE
	 */
	public class EnemyGenerator extends GameObjectGenerator
	{
		private const BOSS_FIRST_STATUT:int = 0;
		private var enemy:Enemy;
		public var enemyType:String;
		
		public function EnemyGenerator()
		{
			super();
		}
		
		override public function generate():void
		{
			var lNum:String = getQualifiedClassName(this).substr(-1);
			
			if (GameLayer.getInstance().children.length > 1)
			{
				enemyType = "Enemy" + lNum;
				
				trace(enemyType)
				
				switch (lNum)
				{
				case "0": 
					enemy = new Enemy0(enemyType);
					break;
				case "1": 
					enemy = new Enemy1(enemyType);
					break;
				case "2": 
					enemy = new Enemy2(enemyType);
					break;
				default: 
					trace("Error");
					break;
				}
				
				Enemy.list.push(enemy);
				
			}
			else
			{
				enemy = new Boss("Boss" + BOSS_FIRST_STATUT);
			}
			
			enemy.x = x;
			enemy.y = y;
			
			enemy.cacheAsBitmap = true;
			
			parent.addChild(enemy);
			enemy.start();
			
			super.generate();
		}
	}

}