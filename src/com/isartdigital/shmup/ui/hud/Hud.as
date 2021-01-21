package com.isartdigital.shmup.ui.hud 
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.ui.UIManager;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.sound.SoundManager;
	import com.isartdigital.utils.ui.Screen;
	import com.isartdigital.utils.ui.UIPosition;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * Classe en charge de gérer les informations du Hud
	 * @author Mathieu ANTHOINE
	 */
	public class Hud extends Screen 
	{
		
		/**
		 * instance unique de la classe Hud
		 */
		protected static var instance: Hud;
		
		public var mcTopLeft:MovieClip;
		public var mcTopCenter:MovieClip;
		public var mcTopRight:MovieClip;
		public var mcBottomRight:MovieClip;
		
		public var score:TextField;
		public  static var totalScore: int = 0;
		public var btnPause: SimpleButton;
	
		public function Hud() 
		{
			super();
            
			score = mcTopCenter.txtScore;
			
			score.text = "Score :" + totalScore;
			
			mcTopRight.btnPause.addEventListener(MouseEvent.CLICK , pauseButton);
			
			if (!Config.debug && Controller.type != Controller.TOUCH) {
				removeChild(mcBottomRight);
				mcBottomRight = null;
			}
		}
		
		
		public function pauseButton(pEvent : MouseEvent):void 
		{
			SoundManager.getNewSoundFX("click").start();
			GameManager.pause();
		}
		
		
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Hud {
			if (instance == null) instance = new Hud();
			return instance;
		}
		
		override protected function onResize(pEvent:Event = null):void 
		{
			super.onResize(pEvent);
			UIManager.setPosition(mcTopCenter, UIPosition.TOP, 0, 10);
			if(mcBottomRight != null) UIManager.setPosition(mcBottomRight, UIPosition.BOTTOM_RIGHT, 35);
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			//Config.stage.removeEventListener(MouseEvent.CLICK , pauseButton);
			super.destroy();
		}

	}
}