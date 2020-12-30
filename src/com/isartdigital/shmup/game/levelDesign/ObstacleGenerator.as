package com.isartdigital.shmup.game.levelDesign
{
	import com.isartdigital.shmup.game.sprites.Obstacle;
	import com.isartdigital.shmup.game.sprites.Obstacle0;
	import com.isartdigital.shmup.game.sprites.Obstacle1;
	import com.isartdigital.shmup.game.sprites.Obstacle2;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe qui permet de générer des Obstacles dans le GameLayer
	 * @author Mathieu ANTHOINE
	 */
	public class ObstacleGenerator extends GameObjectGenerator
	{
		
		public function ObstacleGenerator()
		{
			super();
		}
		
		/**
		 * Méthode generate surchargeant la méthode de la classe mère
		 * Crée un Obstacle à l'endroit du générateur et retire le générateur
		 * transmet le nom de la classe du generateur à l'instance d'Obstacle lui permettant ainsi de savoir quel Obstacle créer
		 */
		override public function generate():void
		{
			var lNum:String = getQualifiedClassName(this).substr( -1);
			var lObstacle:Obstacle;
			
			var obstacleType = "Obstacle" + lNum;
			
			switch (lNum)
			{
			case "0": 
				lObstacle = new Obstacle0(obstacleType);
				Obstacle.list.push(lObstacle);
				break;
			case "1": 
				lObstacle = new Obstacle1(obstacleType);
				Obstacle.list.push(lObstacle);
				break;
			case "2": 
				lObstacle = new Obstacle2(obstacleType);
				Obstacle.list.push(lObstacle);
				break;
			default: 
				trace("Error");
				break;
			}
			
			lObstacle.x = x;
			lObstacle.y = y;
			
			lObstacle.start();
			
			
			parent.addChild(lObstacle);
			
			super.generate();
		}
	
	}

}