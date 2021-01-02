package com.isartdigital.shmup.game {
	
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.layers.InfiniteLayer;
	import com.isartdigital.shmup.game.layers.ScrollingLayer;
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.shmup.game.sprites.Bomb;
	import com.isartdigital.shmup.game.sprites.Boss;
	import com.isartdigital.shmup.game.sprites.Collectable;
	import com.isartdigital.shmup.game.sprites.CollectableBomb;
	import com.isartdigital.shmup.game.sprites.CollectableFirePower;
	import com.isartdigital.shmup.game.sprites.CollectableFireUpgrade;
	import com.isartdigital.shmup.game.sprites.CollectableLife;
	import com.isartdigital.shmup.game.sprites.CollectableShield;
	import com.isartdigital.shmup.game.sprites.Enemy;
	import com.isartdigital.shmup.game.sprites.Obstacle;
	import com.isartdigital.shmup.game.sprites.Player;
	import com.isartdigital.shmup.game.sprites.ShotBoss;
	import com.isartdigital.shmup.game.sprites.ShotEnemy;
	import com.isartdigital.shmup.game.sprites.ShotPlayer;
	import com.isartdigital.shmup.ui.GameOver;
	import com.isartdigital.shmup.ui.UIManager;
	import com.isartdigital.shmup.ui.WinScreen;
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.Monitor;
	import com.isartdigital.utils.game.GameObject;
    import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.MovieClip;
    import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
    import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
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
		public static var background1: InfiniteLayer;
		public static var background2: InfiniteLayer;
		public static var foreground: InfiniteLayer;	
		public static var playerInstance: Player;
		
		/**
		 * controlleur
		 */
		protected static var _controller:Controller;
        
        public static function get controller():Controller 
        {
            return _controller;
        }

		public function GameManager() { }
		
		

		public static function start(): void {
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
			var lBackground1Class: Class = getDefinitionByName("Background1") as Class;			
			var lBackground2Class: Class = getDefinitionByName("Background2") as Class;
			var lForegroundClass : Class = getDefinitionByName("Foreground") as Class;
			
			playerInstance = Player.getInstance();
			background1 = new lBackground1Class();
			background2 = new lBackground2Class();
			foreground = new lForegroundClass();
			
			background1.init(0.4, GameLayer.getInstance());
			background2.init(0.7, GameLayer.getInstance());
			foreground.init(1.3, GameLayer.getInstance());
			
			var lGameStage : GameStage = GameStage.getInstance();
			
			lGameStage.getGameContainer().addChild(background1);
			lGameStage.getGameContainer().addChild(background2);
			lGameStage.getGameContainer().addChild(GameLayer.getInstance());
			lGameStage.getGameContainer().addChild(foreground);	
			
			GameLayer.getInstance().addChild(Player.getInstance());
			
			var lGlobalPlayerPosition: Point = new Point(Config.stage.stageWidth / 3, Config.stage.stageHeight / 2 );
			var lPlayerPostion: Point = GameLayer.getInstance().globalToLocal(lGlobalPlayerPosition);
			
			Player.getInstance().x =  lPlayerPostion.x
			Player.getInstance().y = lPlayerPostion.y;
			
			Collectable.list.push(new CollectableLife("CollectableLife"));
			Collectable.list.push(new CollectableBomb("CollectableBomb"));
			Collectable.list.push(new CollectableFirePower("CollectableFirePower"));
			Collectable.list.push(new CollectableFireUpgrade("CollectableFireUpgrade"));
			Collectable.list.push(new CollectableFireUpgrade("CollectableFireUpgrade"));
			
			
			for (var i:int = 0; i < Collectable.list.length; i++) 
			{
				Collectable.list[i].start();
			}
			
            Player.getInstance().start();
			GameLayer.getInstance().start();
			background1.start();
			background2.start();
			foreground.start();	
			
            
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
			background1.doAction();
			background2.doAction();
			foreground.doAction();
			
			Player.getInstance().doAction();
			GameLayer.getInstance().doAction();
			
			for (var f : int = 0 ; f < ShotEnemy.list.length ; f++)
			{
				ShotEnemy.list[f].doAction();
			}
			
			if (ShotPlayer.list.length != 0)
			{
				for (var e : int = 0 ; e < ShotPlayer.list.length ; e++)
				{
					ShotPlayer.list[e].doAction();
				}
			}
			
			for (var i : int = 0; i < Enemy.list.length ; i++ )
			{
				Enemy.list[i].doAction();
			}
			
			for (var j:int = 0; j < Obstacle.list.length ; j++) 
			{
				Obstacle.list[j].doAction();
			}
			
			for (var k:int = 0; k < Collectable.list.length; k++) 
			{
				Collectable.list[k].doAction();
			}
			
			for (var l:int = 0; l  < ShotBoss.list.length ; l++) 
			{
				ShotBoss.list[l].doAction();
			}
			
			Bomb.bomb.doAction();
			
			for (var m:int = 0; m < Boss.listOfPhase.length ; m++) 
			{
				Boss.listOfPhase[m].doAction();
			}
			
			
			if (playerInstance.special != null) playerInstance.special.doAction();
			
			
		}

		public static function gameOver ():void {
			pause();
			GameStage.getInstance().getHudContainer().removeChild(Hud.getInstance());
			GameStage.getInstance().getGameContainer().removeChild(GameLayer.getInstance());
			
			for (var i:int = ShotPlayer.list.length -1; i > -1; i--) 
			{
				ShotPlayer.list[i].destroy();
			}
			
			for (var j:int = ShotEnemy.list.length -1 ; j > -1 ; j--) 
			{
				ShotEnemy.list[j].destroy();
			}
			
			
			GameOver.getInstance().txtScore.text = "Score :" + Hud.getInstance().totalScore;
			
			UIManager.addScreen(GameOver.getInstance());
		}
		
		public static function win():void {
			pause();
			GameStage.getInstance().getHudContainer().removeChild(Hud.getInstance());
			GameStage.getInstance().getGameContainer().removeChild(GameLayer.getInstance());
			
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