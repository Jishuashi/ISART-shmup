package com.isartdigital.shmup.ui
{
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
		
		public var btnPlay:SimpleButton;
		
		public function TitleCard()
		{
			super();
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
		
		override protected function init(pEvent:Event):void
		{
			super.init(pEvent);
			btnPlay.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(pEvent:MouseEvent):void
		{
			UIManager.addScreen(Help.getInstance());
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