package com.isartdigital.shmup.ui {
	
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.ui.Screen;
	
	/**
	 * Manager (Singleton) en charge de gérer les écrans d'interface
	 * @author Mathieu ANTHOINE
	 */
	public class UIManager 
	{
		public function UIManager() 
		{
			
		}

		/**
		 * Ajoute un écran dans le conteneur de Screens en s'assurant qu'il n'y en a pas d'autres
		 * @param	pScreen
		 */
		public static function addScreen (pScreen: Screen): void {
			closeScreens();
			GameStage.getInstance().getScreensContainer().addChild(pScreen);
		}
		
		/**
		 * Supprimer les écrans dans le conteneur de Screens
		 * @param	pScreen
		 */
		public static function closeScreens (): void {
			while (GameStage.getInstance().getScreensContainer().numChildren > 0) {
				Screen(GameStage.getInstance().getScreensContainer().getChildAt(0)).destroy();
				GameStage.getInstance().getScreensContainer().removeChildAt(0);
			}
		}

		/**
		 * lance le jeu
		 */
		 public static function startGame (): void {
			closeScreens();
			GameStage.getInstance().getHudContainer().addChild(Hud.getInstance());			
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public static function destroy (): void {
		}

	}
	
}