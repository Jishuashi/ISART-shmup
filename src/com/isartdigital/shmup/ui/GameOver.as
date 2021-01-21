package com.isartdigital.shmup.ui
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.UIPosition;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		protected static var instance:GameOver;
		
		public var btnRetry:SimpleButton;
		
		public function GameOver()
		{
			super();
			
			btnRetry.addEventListener(MouseEvent.CLICK, retry);
		
		}
		
		public function retry(pEvent:MouseEvent):void
		{
			SoundManager.getNewSoundFX("click").start();
			UIManager.addScreen(Help.getInstance());
			uiLoop.loop();
			GameManager.destroyAllGameObject();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():GameOver
		{
			if (instance == null) instance = new GameOver();
			return instance;
		}
		
		override protected function onResize(pEvent:Event = null):void
		{
			super.onResize(pEvent);
			UIManager.setPosition(mcBackground, UIPosition.FIT_SCREEN);
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			instance = null;
			btnRetry.removeEventListener(MouseEvent.CLICK, retry);
			
			super.destroy();
		}
	
	}

}