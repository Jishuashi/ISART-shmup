package com.isartdigital.shmup.controller 
{
	import flash.ui.GameInputDevice;
	
	/**
	 * Controleur Pad
	 * @author Mathieu ANTHOINE
	 */
	public class ControllerPad extends Controller 
	{
		/**
		 * instance unique de la classe ControllerPad
		 */
		protected static var instance: ControllerPad;
		
		protected static var device: GameInputDevice;

		public function ControllerPad() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): ControllerPad {
			if (instance == null) instance = new ControllerPad();
			return instance;
		}
		
		public static function init (pDevice:GameInputDevice):void {
			device = pDevice;
			device.enabled = true;
		}

		override public function destroy():void 
		{
			instance = null;
		}

	}
}