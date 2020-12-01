package com.isartdigital.shmup.game.layers 
{
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.GameObject;
	import com.isartdigital.utils.game.GameStage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Classe "Plan", chaque plan (y compris le GameLayer) est une instance de Layer ou d'une classe fille de Layer
	 * TODO: A part GameLayer, toutes les instances de ScrollingLayer contiennent 3 MovieClips dont il faut gérer le "clipping" afin de les faire s'enchainer correctement
	 * @author Mathieu ANTHOINE
	 */
	public class ScrollingLayer extends GameObject
	{
		protected var _screenLimits:Rectangle = new Rectangle();
		
		public function ScrollingLayer() 
		{
			super();
		}

		protected function updateScreenLimits ():void {
			var lTopLeft:Point     = new Point (0, 0);
			var lBottomRight:Point = new Point(Config.stage.stageWidth, Config.stage.stageHeight);
			
			lTopLeft     = globalToLocal(lTopLeft);
			lBottomRight = globalToLocal(lBottomRight);
			
			_screenLimits.setTo(lTopLeft.x, lTopLeft.y, lBottomRight.x - lTopLeft.x, lBottomRight.y - lTopLeft.y);
		}
		
		/**
		 * Retourne les coordonnées des 4 coins de l'écran dans le repère du plan de scroll concerné 
		 * Petite nuance: en Y, retourne la hauteur de la SAFE_ZONE, pas de l'écran, car on a choisi de condamner le reste de l'écran (voir cours Ergonomie Multi écran)
		 * @return Rectangle dont la position et les dimensions correspondant à la taille de l'écran dans le repère local
		 */
		public function get screenLimits ():Rectangle {
			return _screenLimits;
		}
        
        override public function destroy():void 
        {
            super.destroy();
            _screenLimits = null;
        }
		
	}

}