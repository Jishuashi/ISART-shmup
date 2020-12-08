package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
    import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
    import com.isartdigital.utils.game.ColliderType;
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * Classe du joueur (Singleton)
	 * En tant que classe héritant de StateObject, Player contient un certain nombre d'états définis par les constantes LEFT_STATE, RIGHT_STATE, etc.
	 * @author Mathieu ANTHOINE
	 */
	public class Player extends StateObject
	{
		
		/**
		 * instance unique de la classe Player
		 */
		protected static var instance: Player;
		
		/**
		 * controleur de jeu
		 */
		protected var controller: Controller;
		
		/**
		 * vitesse du joueur
		 */
		protected var speed:Number = 25;
		
		public function Player() 
		{
			super();
            controller = GameManager.controller;
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			
			var lHorizontal : Number = controller.right - controller.left;
			var lVertical : Number = controller.down - controller.up;
			
			var lHypotenus : Number = Math.sqrt(lHorizontal *  lHorizontal +  lVertical * lVertical);
			
			if (lHypotenus > 1)
			{
				lHorizontal /= lHypotenus;
				lVertical /= lHypotenus;
			}
			
			if (lVertical == 0 && lHorizontal == 0)
			{
				setState("default");
			}
			else if (lVertical == 0 && lHorizontal == 1)
			{
				setState("right");
			}
			else if (lVertical == 1 && lHorizontal == 0)
			{
				setState("down");
			}
			else if (lVertical == -1 && lHorizontal == 0)
			{
				setState("up");
			}
			else if (lVertical == 0 && lHorizontal == -1)
			{
				setState("left");
			}
			
			x -= GameLayer.getInstance().speed;			
			x += lHorizontal * speed;
			y += lVertical * speed;
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Player {
			if (instance == null) instance = new Player();
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