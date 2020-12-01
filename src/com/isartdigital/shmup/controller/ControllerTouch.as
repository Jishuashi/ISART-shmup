package com.isartdigital.shmup.controller 
{

	
	/**
	 * Controleur Touch
	 * @author Mathieu ANTHOINE
	 */
	public class ControllerTouch extends Controller
	{
		/**
		 * instance unique de la classe ControllerTouch
		 */
		protected static var instance: ControllerTouch;

		public function ControllerTouch() 
		{
			super();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): ControllerTouch {
			if (instance == null) instance = new ControllerTouch();
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