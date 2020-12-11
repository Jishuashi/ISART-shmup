package com.isartdigital.shmup.game.levelDesign
{
	
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.sprites.Boss;
	import com.isartdigital.shmup.game.sprites.Enemy;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe qui permet de générer des classes d'ennemis
	 * TODO: S'inspirer de la classe ObstacleGenerator pour le développement
	 * @author Mathieu ANTHOINE
	 */
	public class EnemyGenerator extends GameObjectGenerator
	{
		
		public function EnemyGenerator()
		{
			super();
		
		}
		
		override public function generate():void
		{
			var lNum:String = getQualifiedClassName(this).substr( -1);
			const BOSS_FIRST_STATUT : int = 0;
			
			if (GameLayer.getInstance().children.length > 1)
			{
				var lEnemy:Enemy = new Enemy("Enemy" + BOSS_FIRST_STATUT);
			}
			else
			{				
				lEnemy = new Boss("Boss" + 0);
			}
			
			lEnemy.x = x;
			lEnemy.y = y;
			lEnemy.start();
			parent.addChild(lEnemy);
			
			super.generate();
		}
	}

}