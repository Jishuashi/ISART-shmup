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
	public class PauseScreen extends Screen
	{
		
		public var btnResume:SimpleButton;
		public var btnQuit:SimpleButton;
		
		private var ambienceSound : SoundFX;
		private var levelSound : SoundFX;
		private var uiSound : SoundFX;
		
		/**
		 * instance unique de la classe PauseScreen
		 */
		protected static var instance:PauseScreen;
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():PauseScreen
		{
			if (instance == null) instance = new PauseScreen();
			return instance;
		}
		
		public function uiLoopPass(pUiSound : SoundFX):void 
		{
			uiSound = pUiSound;	
		}
		
		public function PauseScreen()
		{
			super();
			
			trace(btnQuit)
			trace(btnResume)
			
			btnResume.addEventListener(MouseEvent.CLICK, pauseResume);
			btnQuit.addEventListener(MouseEvent.CLICK, quit)
			
			if(uiSound != null) uiSound.stop();
			
			if (instance != null) trace("Tentative de création d'un autre singleton.");
			else instance = this;
		
		}
		
		public function soundPass(pLevelSound : SoundFX , pAmbienceSound :SoundFX ):void 
		{
			levelSound = pLevelSound;
			ambienceSound = pAmbienceSound;
		}
		
		
		
		public function quit(pEvent:MouseEvent):void
		{
			SoundManager.getNewSoundFX("click").start();
			
			levelSound.stop();
			ambienceSound.stop();
			
			UIManager.addScreen(TitleCard.getInstance());	
			
			GameManager.destroyAllGameObject();
		}
		
		public function pauseResume(pEvent:MouseEvent):void
		{
			SoundManager.getNewSoundFX("click").start();
			GameManager.resume();
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			super.destroy();
			instance = null;
		
		}
	
	}
}