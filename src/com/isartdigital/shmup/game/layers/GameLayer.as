package com.isartdigital.shmup.game.layers
{
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.shmup.game.levelDesign.GameObjectGenerator;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.GameStage;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	//import com.isartdigital.utils.Debug;
	
	/**
	 * Classe "plan de jeu", elle contient tous les éléments du jeu, Generateurs, Player, Ennemis, shots...
	 * @author Mathieu ANTHOINE
	 */
	public class GameLayer extends ScrollingLayer
	{
		
		/**
		 * instance unique de la classe GameLayer
		 */
		protected static var instance:GameLayer;
		protected var ennemiesGenerator:EnemyGenerator = new EnemyGenerator;
	
		
		private var _speed:int = -8;
		
		public function get speed():int
		{
			return _speed;
		}
		
		public function GameLayer()
		{
			super();
		}
		
		
		override public function start():void 
		{
			super.start();
			
			updateScreenLimits();
		}
		
		
		override protected function doActionNormal():void
		{
			x += _speed;
			
			
		 
			updateScreenLimits();
			
			if (children.length != 0)
			{
				if (children[0].x < screenLimits.right + 200 ) 
				{
					GameObjectGenerator(children[0]).generate();
					children.shift();
				}
			}
			
			
		
		}
		
		/**s
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():GameLayer
		{
			if (instance == null) instance = new GameLayer();
			return instance;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			instance = null;
			super.destroy();
		}
	
	}
}