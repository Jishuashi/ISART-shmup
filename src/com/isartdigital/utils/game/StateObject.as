package com.isartdigital.utils.game {
	import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe de base des objets interactifs ayant plusieurs états graphiques
	 * Elle gère la représentation graphique (renderer) et les conteneurs utiles au gamePlay (collider) qui peuvent être de simples boites de collision ou beaucoup plus
	 * suivant l'implémentation faite par le développeur dans les classes filles
	 * @author Mathieu ANTHOINE
	 */
	public class StateObject extends GameObject 
	{
		/**
		 * renderer (animation) de l'état courant
		 */
		protected var renderer:MovieClip;
		
		/**
		 * collider de l'état courant ou collider générale si multiColliders est false
		 */
		protected var collider:MovieClip;
		
		/**
		 * suffixe du nom d'export des Symboles Animés
		 */
		protected static const RENDERER_SUFFIX:String = "";
		
		/**
		 //* suffixe du nom d'export des Symboles collider
		 */
		protected static const COLLIDER_SUFFIX:String = "_collider";	
		
		/**
		 * etat par défaut
		 */
		protected const DEFAULT_STATE:String = "default";
		
		/**
		 * Nom de l'asset (sert à identifier les symboles utilisées dans les fichiers assets.fla et colliders.fla)
		 */
		protected var assetName:String;
		
		/**
		 * état en cours
		 */
		protected var state:String;
		
		/**
		 * Animation de renderer qui boucle ou pas
		 * l'animation de renderer n'est jamais stoppée même quand loop est false
		 * l'animation de renderer ne renvoie jamais isAnimEnd si loop est true
		 */
		protected var loop:Boolean;
		
		/**
		 * Si colliderType est NONE, il n'y aura pas de collider, 
         * si colliderType est SIMPLE, seul un Symbole sert de collider pour tous les états son nom de symbole sera assetName+"_"+COLLIDER_SUFFIX
         * si colliderType est MULTIPLE, un symbole collider par état sera utilisé avec pour noms de symbole assetName+"_"state+"_"+COLLIDER_SUFFIX
         * si colliderType est SELF, le renderer sera utilisé comme collider
		 */
		protected function get colliderType():int {
            return ColliderType.SIMPLE;
        }
		
		/**
		 * niveau d'alpha des colliders, si l'alpha est à 0 (valeur par défaut), les colliders sont en fait invisibles
		 */
		public static var colliderAlpha:Number = 0;
		
		/**
		 * niveau d'alpha des graphismes, si l'alpha est à 0 (valeur par défaut), les graphismes sont en fait invisibles
		 */
		public static var rendererAlpha:Number=1;
		
		public function StateObject() 
		{
			super();
			
            if (assetName == null) 
                assetName = getQualifiedClassName(this).split("::").pop();
			
            setState (DEFAULT_STATE);
		}
		
		/**
		 * défini l'état courant du MySprite
		 * @param	pState nom de l'état. Par exemple si pState est "run" et assetName "Player", renderer va chercher l'export "Player_run" dans le fichier assets.fla et collider "Player_run_collider" dans le fichier colliders.fla
		 * @param	pLoop l'animation boucle (isAnimEnd sera toujours false) ou pas
		 * @param	pStart lance l'animation à cette frame
		 */
		protected function setState (pState:String, pLoop:Boolean = false, pStart:uint = 1): void {
			
			if (state == pState) return;
			
			clearState();
			
			loop = pLoop;
			
			var lClass:Class = getDefinitionByName(assetName+"_" + pState+RENDERER_SUFFIX) as Class;
			
			renderer = new lClass();
			addChild(renderer);
			
			if (rendererAlpha == 0) 
                renderer.visible = false;
			else 
                renderer.alpha = rendererAlpha;
			
			if (renderer.totalFrames > 1) 
                renderer.gotoAndPlay(pStart);
			
			if ((collider == null || colliderType == ColliderType.MULTIPLE) && colliderType != ColliderType.NONE) {
                if (colliderType == ColliderType.SELF){
                    collider = renderer;
                } else {
                    if (colliderType == ColliderType.SIMPLE){
                        lClass = getDefinitionByName(assetName + COLLIDER_SUFFIX) as Class;
                    } else if (colliderType == ColliderType.MULTIPLE){
                        lClass = getDefinitionByName(assetName + "_" + pState + COLLIDER_SUFFIX) as Class;
                    }
                    
                    collider = new lClass();
                    
                    if (colliderAlpha == 0) 
                        collider.visible = false;
                    else 
                        collider.alpha = colliderAlpha;
                    
                    addChild (collider);
                }	
			}
			
			state = pState;
			
		}
		
		/**
		 * nettoie les conteneurs renderer et collider
		 * @param	pDestroy force un nettoyage complet
		 */
		protected function clearState (pDestroy:Boolean=false): void {
			if (state != null) {
                clearRenderer();
                
                if (pDestroy || colliderType == ColliderType.MULTIPLE)
                    clearCollider();
			}
            
			state = null;
		}
        
        protected function clearRenderer():void {
            if (renderer != null){
                renderer.stop();
                removeChild(renderer);
                renderer = null;
            }
        }
        
        protected function clearCollider():void {
            if (collider != null) {
                if (colliderType != ColliderType.SELF)
                    removeChild(collider);
                
                collider = null;
            }
        }
		
		/**
		 * met en pause l'animation
		 */
		public function pause ():void {
			if (renderer != null) StateObject.pauseChildren(renderer);
		}
		
		static protected function pauseChildren (pParent:DisplayObjectContainer):void {
            if (pParent is MovieClip)
                MovieClip(pParent).stop();
            
            var lChild:DisplayObject;
            
			for (var i:int = pParent.numChildren-1; i > -1; i--){
                lChild = pParent.getChildAt(i);
                
                if (lChild is DisplayObjectContainer) 
                    StateObject.pauseChildren(DisplayObjectContainer(lChild));
            }
		}
		
		/**
		 * relance l'animation
		 */
		public function resume ():void {
			if (renderer != null) 
                StateObject.resumeChildren(renderer);
		}
		
		static protected function resumeChildren (pParent:DisplayObjectContainer):void {
			if (pParent is MovieClip)
                MovieClip(pParent).play();
            
            var lChild:DisplayObject;
            
			for (var i:int = pParent.numChildren-1; i > -1; i--){
                lChild = pParent.getChildAt(i);
                
                if (lChild is DisplayObjectContainer) 
                    StateObject.resumeChildren(DisplayObjectContainer(lChild));
            }
		}
		
		/**
		 * précise si l'animation est arrivée à la fin
		 * @return animation finie ou non
		 */
		public function isAnimEnd (): Boolean {
			return !loop && renderer != null && renderer.currentFrame == renderer.totalFrames;
		}
		
		/**
		 * retourne la zone de hit de l'objet
		 * fonction getter: est utilisé comme une propriété ( questionner hitBox et non hitBox() )
		 */
		public function get hitBox (): DisplayObject {
			return collider;
		}
		
		/**
		 * retourne un tableau de boites de collision
		 */
		public function get hitBoxes (): Vector.<DisplayObject> {
			return null;
		}

		/**
		 * retourne un tableau de points de collision
		 */
		public function get hitPoints (): Vector.<Point> {
			return null;
		}

		/**
		 * nettoyage et suppression de l'instance
		 */
		override public function destroy (): void {
			clearState(true);
			super.destroy();
		}
		
	}

}