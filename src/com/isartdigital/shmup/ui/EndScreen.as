package com.isartdigital.shmup.ui 
{
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.Screen;
	import com.isartdigital.utils.ui.UIPosition;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * Classe mère des écrans de fin
	 * @author Mathieu ANTHOINE
	 */
	public class EndScreen extends Screen 
	{
		
		public var mcBackground:Sprite;
		public var mcScore:Sprite;
		public var txtScore: TextField ;
		
		public var btnNext:SimpleButton;
		
		public static var uiLoop : SoundFX;
	
		public function EndScreen() 
		{
			super();
			txtScore = mcScore.getChildByName("txtScore") as TextField;
			
			btnNext.addEventListener(MouseEvent.CLICK , next);
		}
		
		
		public function next(pEvent : MouseEvent):void 
		{
			SoundManager.getNewSoundFX("click").start();
			uiLoop.loop();
			UIManager.addScreen(TitleCard.getInstance());
		}
		
		
		public static function uiSoundPass(pSound : SoundFX):void 
		{
			uiLoop = pSound;
		}
		
		override protected function onResize(pEvent:Event = null):void 
		{
			super.onResize(pEvent);
			UIManager.setPosition(mcBackground,UIPosition.FIT_SCREEN);			
		}
		
		override public function destroy():void 
		{
			btnNext.removeEventListener(MouseEvent.CLICK , next);
			super.destroy();
		}
	}
}