package com.isartdigital.shmup.ui
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.ui.UIManager;
    import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.Screen;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Ecran principal
	 * @author Mathieu ANTHOINE
	 */
	public class TitleCard extends Screen
	{
		
		/**
		 * instance unique de la classe TitleCard
		 */
		protected static var instance:TitleCard;
		
		public var uiSound : SoundFX = SoundManager.getNewSoundFX("uiLoop");
		
		
		
		public var btnPlay:SimpleButton;
		public var btnCredits : SimpleButton;
		
		
		public function waitingtime():void 
		{
			var lWaitingTime  :int = 50;
			var lCounterFrame  :int = 0;
			
			if (lCounterFrame++ >= lWaitingTime)
			{
				GameManager.isCredits = false;
				lCounterFrame = 0;
			}
		}
		
		public function TitleCard()
		{
			super();
			
			
			if (!GameManager.isCredits)
			{
				uiSound.loop();
			}
			
			EndScreen.uiSoundPass(uiSound);
			PauseScreen.getInstance().uiLoopPass(uiSound);
			
			btnCredits.addEventListener(MouseEvent.CLICK , credits);
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():TitleCard
		{
			if (instance == null) instance = new TitleCard();
			return instance;
		}
		
		public function credits(pEvent : MouseEvent):void 
		{
			SoundManager.getNewSoundFX("click").start();
			UIManager.addScreen(Credits.getInstance());
		}
		
		override protected function init(pEvent:Event):void
		{
			super.init(pEvent);
			btnPlay.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(pEvent:MouseEvent):void
		{
			UIManager.addScreen(Help.getInstance());
			Help.getInstance().uiSoundPass(uiSound);
			SoundManager.getNewSoundFX("click").start();
		}
		
		
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			btnPlay.removeEventListener(MouseEvent.CLICK, onClick);
			instance = null;
			super.destroy();
		}
	
	}
}