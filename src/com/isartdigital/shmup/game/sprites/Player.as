package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.Monitor;
	import com.isartdigital.utils.game.ColliderType;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import utils.math.MathTools;
	
	/**
	 * Classe du joueur (Singleton)
	 * En tant que classe héritant de StateObject, Player contient un certain nombre d'états définis par les constantes LEFT_STATE, RIGHT_STATE, etc.
	 * @author Mathieu ANTHOINE
	 */
	public class Player extends StateObject
	{
		
		/**
		 * instance unique de la classe Player
		 */
		protected static var instance:Player;
		
		/**
		 * controleur de jeu
		 */
		protected var controller:Controller;
		
		/**
		 * vitesse du joueur
		 */
		public static var nbOfCannon:int = 1;
		protected var speed:Number = 10;
		public static var weaponLevel:int = 2;
		private var weapon:MovieClip;
		public static var playerCollider:MovieClip;
		protected var weaponPlayerNextLevel:MovieClip;
		private var weaponPlayer:MovieClip;
		private var weaponClass:Class;
		private var indexShotAsset:int = 0;
		private var waitingTime:int = 5;
		private var countFrame:int = 0;
		
		public function Player()
		{
			super();
			
			controller = GameManager.controller;
			playerCollider = MovieClip(getChildAt(1));
			scaleX = scaleY = 0.8;
		
		}
		
		override protected function doActionNormal():void
		{
			
			var lHorizontal:Number = controller.right - controller.left;
			var lVertical:Number = controller.down - controller.up;
			
			var lHypotenus:Number = Math.sqrt(lHorizontal * lHorizontal + lVertical * lVertical);
			
			if (lHypotenus > 1)
			{
				lHorizontal /= lHypotenus;
				lVertical /= lHypotenus;
			}
			
			if (lVertical == 0 && lHorizontal == 0)
			{
				setState("default");
			}
			else if (lVertical == 0 && lHorizontal == 1)
			{
				setState("right");
			}
			else if (lVertical == 1 && lHorizontal == 0)
			{
				setState("down");
			}
			else if (lVertical == -1 && lHorizontal == 0)
			{
				setState("up");
			}
			else if (lVertical == 0 && lHorizontal == -1)
			{
				setState("left");
			}
			
			weaponPlayerNextLevel = MovieClip(renderer.getChildAt(0)).mcWeapon;
			
			doShotNormal();
			for (var i:int = ShotEnemy.list.length - 1; i > -1; i--)
			{
				doCollision(ShotEnemy.list[i]);
			}
			
			if (weaponPlayerNextLevel != weaponPlayer)
			{
				weaponPlayer = weaponPlayerNextLevel;
				weaponPlayer.addChild(weapon);
				weapon.stop();
			}
			
			x -= GameLayer.getInstance().speed;
			x += lHorizontal * speed;
			y += lVertical * speed;
		}
		
		public function doShotNormal():void
		{
			
			var lShot:ShotPlayer
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point
			
			if (controller.fire)
			{
				switch (weaponLevel)
				{
				case 0: 
					nbOfCannon = 1;
					break;
				case 1: 
					nbOfCannon = 3;
					break;
				case 2: 
					nbOfCannon = 5;
				}
				
				if (countFrame++ >= waitingTime)
				{
					
					for (var i:int = 0; i < nbOfCannon; i++)
					{
						lShot = new ShotPlayer("ShotPlayer" + indexShotAsset);
						lPosition = Config.stage.globalToLocal(Player.getInstance().localToGlobal(new Point(playerCollider.getChildByName("mcWeapon" + i).x, playerCollider.getChildByName("mcWeapon" + i).y)));
						lRadian = playerCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
						lVelocity = new Point(Math.cos(lRadian) * ShotPlayer.SHOT_SPEED, Math.sin(lRadian) * ShotPlayer.SHOT_SPEED);
						
						lShot.x = lPosition.x;
						lShot.y = lPosition.y;
						
						lShot.rotation = playerCollider.getChildByName("mcWeapon" + i).rotation;
						
						lShot.cacheAsBitmap = true;
						
						lShot.scaleX = lShot.scaleY = 0.3;
						
						ShotPlayer.shotList.push(lShot);
						ShotPlayer.shotVelocities.push(lVelocity);
						
						Config.stage.addChild(lShot);
						countFrame = 0;
					}
				}
				
			}
		}
		
		private function doCollision(pTarget:StateObject)
		{
			if (CollisionManager.hasCollision(hitBox, pTarget.hitBox, hitPoints))
			{
				doAction = doActionHurt;
			}
		
		}
		
		public function doActionHurt():void
		{
			
			var lHorizontal:Number = controller.right - controller.left;
			var lVertical:Number = controller.down - controller.up;
			
			var lHypotenus:Number = Math.sqrt(lHorizontal * lHorizontal + lVertical * lVertical);
			
			if (lHypotenus > 1)
			{
				lHorizontal /= lHypotenus;
				lVertical /= lHypotenus;
			}
			
			setState("hurt");
		
			
			if (isAnimEnd())
			{
				setState("default")
				doAction = doActionNormal;
			}
			
			x -= GameLayer.getInstance().speed;
			x += lHorizontal * speed;
			y += lVertical * speed;
		}
		
		override public function get hitPoints():Vector.<Point>
		{
			var lPosHitPoints:Vector.<Point> = new Vector.<Point>();
			var lPosition:Point;
			var lChild:DisplayObject;
			
			for (var i:int = 0; i < 4; i++)
			{
				lChild = playerCollider.getChildByName("mcHitPoint" + i);
				lPosition = playerCollider.localToGlobal(new Point(lChild.x, lChild.y));
				lPosHitPoints.push(lPosition);
			}
			
			return lPosHitPoints;
		}
		
		override public function start():void
		{
			super.start();
			
			weaponPlayer = MovieClip(renderer.getChildAt(0)).mcWeapon;
			weaponClass = getDefinitionByName("Weapon" + weaponLevel) as Class;
			weapon = new weaponClass();
			weaponPlayer.addChild(weapon);
			weapon.stop();
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance():Player
		{
			if (instance == null) instance = new Player();
			return instance;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy():void
		{
			instance = null;
			super.destroy();
		}
	
	}
}