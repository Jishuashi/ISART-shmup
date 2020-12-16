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
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
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
		private var mcWeapon:MovieClip;
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
			
			doShot();
			
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
		
		public function doShot():void
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
					if (countFrame++ >= waitingTime)
					{
						nbOfCannon = 1;
						
						lShot = new ShotPlayer("ShotPlayer" + indexShotAsset);
						lPosition = parent.globalToLocal(parent.localToGlobal(new Point(playerCollider.mcWeapon0.x, playerCollider.mcWeapon0.y)));
						lRadian = playerCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
						lVelocity = new Point(Math.cos(lRadian) * ShotPlayer.SHOT_SPEED, Math.sin(lRadian) * ShotPlayer.SHOT_SPEED);
						
						lShot.x = lPosition.x;
						lShot.y = lPosition.y;
						
						lShot.rotation = playerCollider.getChildByName("mcWeapon" + i).rotation;
						
						lShot.scaleX = lShot.scaleY = 0.3;
						
						lShot.cacheAsBitmap = true;
						
						ShotPlayer.shotList.push(lShot);
						ShotPlayer.shotVelocities.push(lVelocity);
						
						parent.addChild(lShot);
						countFrame = 0;
					}
					break;
				case 1:
					
					if (countFrame++ >= waitingTime)
					{
						
						for (var i:int = 0; i < nbOfCannon; i++)
						{
							nbOfCannon = 3;
							
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
					break;
				case 2:
					if (countFrame++ >= waitingTime)
					{
						
						for (var f:int = 0; f < nbOfCannon; f++)
						{
							nbOfCannon = 5;
							
							lShot = new ShotPlayer("ShotPlayer" + indexShotAsset);
							lPosition = Config.stage.globalToLocal(Player.getInstance().localToGlobal(new Point(playerCollider.getChildByName("mcWeapon" + f).x, playerCollider.getChildByName("mcWeapon" + f).y)));
							lRadian = playerCollider.getChildByName("mcWeapon" + f).rotation * MathTools.DEG2RAD;
							lVelocity = new Point(Math.cos(lRadian) * ShotPlayer.SHOT_SPEED, Math.sin(lRadian) * ShotPlayer.SHOT_SPEED);
							
							lShot.x = lPosition.x;
							lShot.y = lPosition.y;
							
							lShot.rotation = playerCollider.getChildByName("mcWeapon" + f).rotation;
							
							lShot.scaleX = lShot.scaleY = 0.3;
							
							lShot.cacheAsBitmap = true;
							
							ShotPlayer.shotList.push(lShot);
							ShotPlayer.shotVelocities.push(lVelocity);
							
							Config.stage.addChild(lShot);
							countFrame = 0;
						}
					}
					break;
					
				}
				
			}
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