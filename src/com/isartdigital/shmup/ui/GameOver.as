package com.isartdigital.shmup.ui 
{
	import com.isartdigital.utils.ui.UIPosition;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * Classe Game OVer (Singleton)
	 * @author Mathieu ANTHOINE
	 */
	public class GameOver extends EndScreen 
	{
		/**
		 * instance unique de la classe GameOver
		 */
		protected static var instance: GameOver;
		
		public var btnQuit:SimpleButton;
		
		
		public function GameOver() 
		{
			super();
			
			
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GameOver {
			if (instance == null) instance = new GameOver();
			return instance;
		}
		
		override protected function onResize(pEvent:Event = null):void 
		{
			super.onResize(pEvent);
			UIManager.setPosition(mcBackground,UIPosition.FIT_SCREEN);			
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