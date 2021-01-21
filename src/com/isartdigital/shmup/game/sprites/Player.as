package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.controller.Controller;
	import com.isartdigital.shmup.controller.ControllerKey;
	import com.isartdigital.shmup.controller.ControllerPad;
	import com.isartdigital.shmup.controller.ControllerTouch;
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.ui.GameOver;
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.Monitor;
	import com.isartdigital.utils.game.ColliderType;
	import com.isartdigital.utils.game.CollisionManager;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
	import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
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
		protected var speed:Number = 10;
		
		private var nbOfCannon:int = 1;
		public var weaponLevel:int = 0;
		public var weaponNextLevel:int = weaponLevel + 1;
		public var life:int = 3;
		public var weaponDamage:int = 1;
		
		private var waitingTime:int = 10;
		private var waitingTimeSpecial:int = 60;
		private var waitingTimeGodMode:int = 120;
		
		private var countFrame:int = 0;
		private var countFrameSpecial:int = 120;
		private var countFrameGodMode:int = 0;
		
		public var invincible:Boolean = false;
		public var bombOn:Boolean = false;
		public var godModeOn:Boolean = false;
		
		public var shield:Shield;
		
		private var weapon:MovieClip;
		public static var playerCollider:MovieClip;
		protected var weaponPlayerNextLevel:MovieClip;
		private var weaponPlayer:MovieClip;
		
		public var bomb:Bomb = new Bomb("Bomb");
		
		public var special:Special;
		
		private var weaponClass:Class;
		
		public var nbOfBomb:int = 2;
		
		private var pushButtonGodMod:Boolean = false;
		
		public function Player()
		{
			super();
			
			controller = GameManager.controller;
			playerCollider = MovieClip(getChildAt(1));
			scaleX = scaleY = 0.8;
		
		}
		
		override protected function doActionNormal():void
		{
			
			if (GameManager.startOn)
			{
				x += 5;
			}
			
			
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
			
			if (shield != null)
			{
				shield.doAction();
			}
			
			if (!invincible)
			{
				for (var i:int = Obstacle.list.length - 1; i > -1; i--)
				{
					doCollision(Obstacle.list[i]);
				}
				
				for (var j:int = Enemy.list.length - 1; j > -1; j--)
				{
					doCollision(Enemy.list[j]);
				}
				
			}
			
			if (weaponLevel == weaponNextLevel && weaponLevel < 3 && weaponLevel > -1)
			{
				weaponPlayer.removeChild(weapon);
				
				weaponNextLevel++;
				
				weaponPlayer = MovieClip(renderer.getChildAt(0)).mcWeapon;
				weaponClass = getDefinitionByName("Weapon" + weaponLevel) as Class;
				weapon = new weaponClass();
				weaponPlayer.addChild(weapon);
				weapon.stop();
			}
			
			if (godModeOn)
			{
				invincible = true;
			}
			else
			{
				invincible = false;
			}
			
			if (Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x < 5)
			{
				
				Hud.getInstance().mcTopLeft.mcSpecialBar.mcBar.x += 0.2;
			}
			
			weaponPlayerNextLevel = MovieClip(renderer.getChildAt(0)).mcWeapon;
			
			doShotNormal();
			doBomb();
			doSpecial();
			doGodMode();
			
			if (weaponPlayerNextLevel != weaponPlayer)
			{
				weaponPlayer = weaponPlayerNextLevel;
				weaponPlayer.addChild(weapon);
				weapon.stop();
			}
			
			if (countFrameGodMode++ >= waitingTimeGodMode && pushButtonGodMod)
			{
				pushButtonGodMod = false;
				countFrameGodMode = 0;
			}
			
			x -= GameLayer.getInstance().speed;
			x += lHorizontal * speed;
			y += lVertical * speed;
		}
		
		public function doBomb():void
		{
			if (controller.bomb)
			{
				if (nbOfBomb > 0 && !bombOn)
				{
					bombOn = true;
					Hud.getInstance().mcTopLeft.getChildByName("mcGuide" + (nbOfBomb - 1)).visible = false;
					nbOfBomb -= 1;
					Bomb.debug = false;
					SoundManager.getNewSoundFX("bomb").start();
					trace("Booooooooom!")
					bomb.spawnBomb();
					
				}
			}
		
		}
		
		public function doGodMode():void
		{
			if (controller.god && !pushButtonGodMod)
			{
				if (godModeOn)
				{
					godModeOn = false;
					trace("GodMode Desactivé");
					pushButtonGodMod = true;
					return;
				}
				else
				{
					godModeOn = true;
					trace("GodMode Activé");
					pushButtonGodMod = true;
					return;
				}
			}
		}
		
		public function doShield():void
		{
			trace("Hello");
		}
		
		public function doSpecial():void
		{
			var lShot:ShotPlayer;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			var lSpecialCollider:MovieClip = playerCollider.mcSpecial;
			
			if (controller.special)
			{
				if (countFrameSpecial++ >= waitingTimeSpecial)
				{
					lPosition = parent.globalToLocal(Player.getInstance().localToGlobal(new Point(lSpecialCollider.x, lSpecialCollider.y)));
					lRadian = lSpecialCollider.rotation * MathTools.DEG2RAD;
					lVelocity = new Point(Math.cos(lRadian) * Special.SPEED_SPE, Math.sin(lRadian) * Special.SPEED_SPE);
					special = new Special("Special", lVelocity);
					
					special.x = lPosition.x;
					special.y = lPosition.y;
					
					special.rotation = lSpecialCollider.rotation;
					
					special.cacheAsBitmap = true;
					
					special.scaleX = special.scaleY = 0.8;
					
					special.start();
					
					parent.addChild(special);
					countFrameSpecial = 0;
				}
				
			}
		}
		
		public function doShotNormal():void
		{
			
			var lShot:ShotPlayer;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			var lSoundShot : SoundFX = SoundManager.getNewSoundFX("playerShoot0");
			
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
					break;
				}
				
				if (countFrame++ >= waitingTime)
				{
					
					lSoundShot.start();
					
					for (var i:int = 0; i < nbOfCannon; i++)
					{
						weapon.play();
						
						lPosition = parent.globalToLocal(Player.getInstance().localToGlobal(new Point(playerCollider.getChildByName("mcWeapon" + i).x, playerCollider.getChildByName("mcWeapon" + i).y)));
						lRadian = playerCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
						lVelocity = new Point(Math.cos(lRadian) * ShotPlayer.SHOT_SPEED, Math.sin(lRadian) * ShotPlayer.SHOT_SPEED);
						
						if (weaponLevel == 0) lShot = new ShotPlayer0("ShotPlayer0", lVelocity);
						if (weaponLevel == 1) lShot = new ShotPlayer1("ShotPlayer1", lVelocity);
						if (weaponLevel == 2) lShot = new ShotPlayer2("ShotPlayer2", lVelocity);
						
						lShot.x = lPosition.x;
						lShot.y = lPosition.y;
						
						lShot.rotation = playerCollider.getChildByName("mcWeapon" + i).rotation;
						
						lShot.cacheAsBitmap = true;
						
						lShot.scaleX = lShot.scaleY = 1, 5;
						
						lShot.start();
						ShotPlayer.list.push(lShot);
						
						
						
						parent.addChild(lShot);
						
						countFrame = 0;
						
						
						if (isAnimEnd())
						{
							lSoundShot.stop();
							weapon.stop();
						}
					}
				}				
			}
		}
		
		private function doCollision(pTarget:StateObject)
		{
			if (CollisionManager.hasCollision(hitBox, pTarget.hitBox, hitPoints))
			{
				
				if (pTarget is Obstacle2 && !invincible && !Shield.shieldOn)
				{
					pTarget.doAction = Obstacle2(pTarget).doExplosion;
					doAction = doActionHurt;
				}
				
				if (pTarget is Enemy && !invincible && !Shield.shieldOn)
				{
					pTarget.doAction = Enemy(pTarget).doDestroy;
					doAction = doActionHurt;
				}
			}
		}
		
		public function doActionHurt():void
		{
			var lSoundHurt:SoundFX = SoundManager.getNewSoundFX("loseLife");
			
			setState("hurt");
			
			if (isAnimEnd())
			{
				lSoundHurt.start();
				
				var lHud:Hud = Hud.getInstance();
				
				setState("default")
				
				if (!invincible)
				{
					life -= 1;
					
					if (life == 2)
					{
						trace(life)
						lHud.mcTopRight.mcGuide2.visible = false;
						
						if (!Shield.shieldOn)
						{
							GameManager.shield = new Shield("Shield");
							
							GameManager.shield.x = x;
							GameManager.shield.y = y;
							
							GameManager.shield.start();
							
							Shield.shieldOn = true;
							
							GameLayer.getInstance().addChild(GameManager.shield);
						}
						
						doAction = doDestroy;
						
					}
					else if (life == 1)
					{
						lHud.mcTopRight.mcGuide1.visible = false;
						
						if (!Shield.shieldOn)
						{
							GameManager.shield = new Shield("Shield");
							
							GameManager.shield.x = x;
							GameManager.shield.y = y;
							
							GameManager.shield.start();
							
							Shield.shieldOn = true;
							
							GameLayer.getInstance().addChild(GameManager.shield);
						}
						
						doAction = doDestroy;
					}
					else if (life <= 0)
					{
						GameManager.gameOver();
					}
				}
				
			}
			
			x -= GameLayer.getInstance().speed;
		}
		
		public function doDestroy():void
		{
			setState("explosion")
			
			if (isAnimEnd())
			{
				
				setState("default")
				
				doAction = doActionNormal;
			}
		
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
