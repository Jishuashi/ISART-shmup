package com.isartdigital.shmup.ui 
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.Screen;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Credits extends Screen 
	{
		
		/**
		 * instance unique de la classe CreditsScreen
		 */
		protected static var instance: Credits;
		
		public var btnQuit : SimpleButton;
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Credits {
			if (instance == null) instance = new Credits();
			return instance;
		}
		
		public function quit(pEvent : MouseEvent):void 
		{
			UIManager.closeScreens();
			SoundManager.getNewSoundFX("click").start();
			
			GameManager.isCredits = true;
			
			UIManager.addScreen(TitleCard.getInstance());
			
			
			TitleCard.getInstance().waitingtime();
		}

		public function Credits() 
		{
			super();
			
			btnQuit.addEventListener(MouseEvent.CLICK , quit);
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void 
		{
			super.destroy();
			btnQuit.removeEventListener(MouseEvent.CLICK , quit);
			instance = null;
		}

	}
}