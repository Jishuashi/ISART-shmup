package com.isartdigital.shmup.game.layers 
{
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
		protected static var instance: GameLayer;
		
		private var _speed : int = -10;
		
		public function get speed():int 
		{
			return _speed;
		}
		
		
		public function GameLayer() 
		{
			super();
		}
		
		override protected function doActionNormal():void 
		{
			x += _speed;
		}
		/**s
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GameLayer {
			if (instance == null) instance = new GameLayer();
			return instance;
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			super.destroy();
		}

	}
}