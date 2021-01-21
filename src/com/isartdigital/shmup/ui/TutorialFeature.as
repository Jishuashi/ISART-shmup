package com.isartdigital.shmup.ui
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.Screen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class TutorialFeature extends Screen
	{
		
		/**
		 * instance unique de la classe TutorialFeature
		 */
		protected static var instance:TutorialFeature;
		
		public var btnNext:SimpleButton;
		
		
		private var uiLoop : SoundFX;
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():TutorialFeature
		{
			if (instance == null) instance = new TutorialFeature();
			return instance;
		}
		
		public function TutorialFeature()
		{
			super();
			
			if (instance != null) trace("Tentative de création d'un autre singleton.");
			else instance = this;
			
			btnNext.addEventListener(MouseEvent.CLICK, onClick);
		
		}
		
		protected function onClick(pEvent:MouseEvent):void
		{
			SoundManager.getNewSoundFX("click").start();
			if(uiLoop != null) uiLoop.stop();
			GameManager.start();
		}
		
		public function uiSoundPass(pSound : SoundFX):void 
		{
			uiLoop = pSound;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			instance = null;
			btnNext.removeEventListener(MouseEvent.CLICK, onClick);
			super.destroy();
		}
	
	}
}