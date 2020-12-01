package com.isartdigital.shmup.game {
	
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.sprites.Player;
	import com.isartdigital.shmup.ui.GameOver;
	import com.isartdigital.shmup.ui.UIManager;
	import com.isartdigital.shmup.ui.WinScreen;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.Monitor;
    import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
    import flash.display.Sprite;
	import flash.events.Event;
    import flash.geom.Point;
	
	/**
	 * Manager (Singleton) en charge de gérer le déroulement d'une partie
	 * @author Mathieu ANTHOINE
	 */
	public class GameManager
	{
		/**
		 * jeu en pause ou non
		 */
		protected static var isPause:Boolean = true;
		
		/**
		 * controlleur
		 */
		protected static var _controller:Controller;
        
        public static function get controller():Controller 
        {
            return _controller;
        }

		public function GameManager() { }

		public static function start (): void {
			// Lorsque la partie démarre, le type de controleur déterminé est actionné
			if (Controller.type == Controller.PAD) 
                _controller = ControllerPad.getInstance();
			else if (Controller.type == Controller.TOUCH) 
                _controller = ControllerTouch.getInstance();
			else 
                _controller = ControllerKey.getInstance();

			Monitor.getInstance().addButton("Game Over",cheatGameOver);
			Monitor.getInstance().addButton("Win", cheatWin);
			Monitor.getInstance().addButton("Colliders", cheatCollider);
			Monitor.getInstance().addButton("Renderers", cheatRenderer);

			UIManager.startGame();
			
			// TODO: votre code d'initialisation commence ici
            
            //Player.getInstance().resume();
            
			resume();
		}
		
		// ==== Mode Cheat =====
		
		protected static function cheatCollider (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			if (StateObject.colliderAlpha < 1) StateObject.colliderAlpha = 1; else StateObject.colliderAlpha = 0;
		}
		
		protected static function cheatRenderer (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			if (StateObject.rendererAlpha < 1) StateObject.rendererAlpha = 1; else StateObject.rendererAlpha = 0;
		}
		
		protected static function cheatGameOver (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			Player.getInstance().destroy();
			gameOver();
		}
		
		protected static function cheatWin (pEvent:Event): void {
			/* les fonctions callBack des méthodes de cheat comme addButton retournent
			 * un evenement qui contient la cible pEvent.target (le composant de cheat)
			 * et sa valeur (pEvent.target.value) à exploiter quand c'est utile */
			win();
		}
		
		/**
		 * boucle de jeu (répétée à la cadence du jeu en fps)
		 * @param	pEvent
		 */
		protected static function gameLoop (pEvent:Event): void {
			// TODO: votre code de gameloop commence ici
		}

		public static function gameOver ():void {
			pause();
			UIManager.addScreen(GameOver.getInstance());
		}
		
		public static function win():void {
			pause();
			UIManager.addScreen(WinScreen.getInstance());
		}
		
		public static function pause (): void {
			if (!isPause) {
				isPause = true;
				Config.stage.removeEventListener (Event.ENTER_FRAME, gameLoop);
			}
		}
		
		public static function resume (): void {
			// donne le focus au stage pour capter les evenements de clavier
			Config.stage.focus = Config.stage;
            
			if (isPause) {
				isPause = false;
				Config.stage.addEventListener (Event.ENTER_FRAME, gameLoop);
			}
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public static function destroy (): void {
			Config.stage.removeEventListener (Event.ENTER_FRAME, gameLoop);
		}

	}
}