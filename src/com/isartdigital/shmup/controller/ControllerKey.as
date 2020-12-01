package com.isartdigital.shmup.controller 
{
	import flash.ui.Keyboard;

	/**
	 * Controleur clavier
	 * @author Mathieu ANTHOINE
	 */
	public class ControllerKey extends Controller
	{
		/**
		 * instance unique de la classe ControllerKey
		 */
		protected static var instance: ControllerKey;
		
		/**
		 * tableau stockant l'etat appuyé ou non des touches
		 */
		protected var keys:Array = new Array();
		
		public function ControllerKey() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): ControllerKey {
			if (instance == null) instance = new ControllerKey();
			return instance;
		}

		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
		}
	}
}