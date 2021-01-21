package com.isartdigital.shmup.game.sprites
{
	import com.greensock.easing.Power0;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.GameStage;
	import com.isartdigital.utils.game.StateObject;
	import com.isartdigital.utils.sound.SoundFX;
	import com.isartdigital.utils.sound.SoundManager;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	import utils.math.MathTools;
	import utils.math.VectorTools;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy extends StateObject
	{
		protected const SHOT_SPEED:int = 15;
		
		protected static var indexShotAsset:int = 0;
		
		public static var list:Vector.<Enemy> = new Vector.<Enemy>();
		
		protected var nbOfCanon:int = 1;
		
		public var allyModeOn:Boolean = false;
		
		protected var indexOfShot:int = 0;
		protected var scoreValue:int;
		protected var waitingTime:int = 0;
		protected var waitingTimeModeAlly:int = 360;
		protected var countFrame:int = 0;
		protected var countFrameModeAlly:int = 0;
		protected var speedY:int = 0;
		protected var speedX:int = 0;
		public var nbOfLife:int;
		
		protected var canGenerateItems:Boolean;
		
		protected var durationInFrame:int;
		
		protected var enemyCollider:MovieClip;
		
		public function Enemy(pAsset:String)
		{
			assetName = pAsset;
			super();
			
			list.push(this);
			
			scaleX = scaleY = 0.8;
		}
		
		override protected function doActionNormal():void
		{
			super.doActionNormal();
			
			move();
			doShotNormal();		
		}
		
		public function doDestroyOutsideOfscreen():void
		{
			var lXMin:Number = GameLayer.getInstance().screenLimits.left;
			
			if (x < lXMin)
			{
				destroy();
			}
		}
		
		public function doActionHurt():void
		{
			setState("hurt");
			
			if (isAnimEnd())
			{
				setState("default")
				doAction = doActionNormal;
			}
		}
		
		public function doExplosion():void
		{
			setState("explosion");
			
			if (isAnimEnd())
			{
				Hud.getInstance().totalScore += scoreValue;
				Hud.getInstance().score.text = "Score :" + Hud.getInstance().totalScore;
				destroy();
			}
		}
		
		protected function doShotNormal():void
		{
			var lShot:ShotEnemy;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			var lSoundShot:SoundFX = SoundManager.getNewSoundFX("enemyShoot");
			
			if (countFrame++ >= waitingTime)
			{
				for (var i:int = 0; i < nbOfCanon; i++)
				{
					
					lPosition = GameLayer.getInstance().globalToLocal(enemyCollider.getChildByName("mcWeapon" + i).localToGlobal(new Point(0, 0)));
					lRadian = enemyCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
					lVelocity = new Point(Math.cos(lRadian) * SHOT_SPEED, Math.sin(lRadian) * SHOT_SPEED);
					
					if (indexOfShot == 0) lShot = new ShotEnemy0("ShotEnemy" + indexShotAsset, lVelocity);
					if (indexOfShot == 1) lShot = new ShotEnemy1("ShotEnemy" + indexShotAsset, lVelocity);
					if (indexOfShot == 2) lShot = new ShotEnemy2("ShotEnemy" + indexShotAsset, lVelocity, this);
					
					lShot.x = lPosition.x;
					lShot.y = lPosition.y;
					
					lShot.rotation = enemyCollider.getChildByName("mcWeapon" + i).rotation;
					
					lShot.scaleX = lShot.scaleY = 0.8;
					
					lShot.cacheAsBitmap = true;
					
					ShotEnemy.list.push(lShot);
					
					parent.addChild(lShot);
					
					//lSoundShot.start();
					
					lShot.start();
					countFrame = 0;
				}
			}
		
		}
		
		protected function move():void
		{
		
		}
		
		public function doDestroy()
		{
			var lSoundExplosion0:SoundFX = SoundManager.getNewSoundFX("enemy0Explosion0");
			var lSoundExplosion1:SoundFX = SoundManager.getNewSoundFX("enemyExplosion");
			
			var lPercent:int = Math.floor(Math.random() * 100);
			var lPrecedentNumber:int;
			
			nbOfLife -= Player.getInstance().weaponDamage;
			
			allyModeOn = false;
			
			if (0 >= nbOfLife)
			{
				
				if (lPercent > 75 && canGenerateItems)
				{
					if (Collectable.list.length == 0)
					{
						Collectable.list.push(new CollectableLife("CollectableLife"));
						Collectable.list.push(new CollectableBomb("CollectableBomb"));
						Collectable.list.push(new CollectableShield("CollectableShield"));
						
						for (var i:int = 0; i < Collectable.list.length; i++)
						{
							Collectable.list[i].start();
						}
					}
					
					var lIndex:int = Math.floor(Math.random() * Collectable.list.length);
					
					if (lIndex == lPrecedentNumber)
					{
						Collectable.list.removeAt(lIndex);
						doAction = doExplosion;
						return;
					}
					
					trace("GENERATE : " + Collectable.list[lIndex].name)
					
					Collectable.list[lIndex].x = x;
					Collectable.list[lIndex].y = y;
					
					lPrecedentNumber = lIndex;
					
					GameLayer.getInstance().addChild(Collectable.list[lIndex]);
				}
				
				doAction = doExplosion;
			}
			else
			{
				if (state != "hurt")
				{
					doAction = doActionHurt;
					
					if (this is Enemy0)
					{
						lSoundExplosion0.start();
					}
					else
					{
						lSoundExplosion1.start();
					}
				}
			}
		
		}
		
		public function setModeAlly():void
		{
			var lPosAllyOfPlayer:Point = new Point(Player.getInstance().x + 100, Player.getInstance().y - 150)
			
			var lRange:RangeAlly = new RangeAlly();
			
			this.addChild(lRange);
			
			lRange.visible = true;
			
			x = lPosAllyOfPlayer.x;
			y = lPosAllyOfPlayer.y;
			
			if (scaleX > 0)
			{
				scaleX *= -1;
			}
			
			if (countFrameModeAlly++ >= waitingTimeModeAlly)
			{
				doAction = doDestroyAlly;
			}
			
			doShotAlly();
			
			x -= GameLayer.getInstance().speed;
		}
		
		public function doDestroyAlly():void
		{
			setState("explosion")
			
			if (isAnimEnd())
			{
				visible = false;
				allyModeOn = false;
				destroy();
				doAction = doActionVoid;
			}
		
		}
		
		public function doShotAlly():void
		{
			var lShot:ShotAlly;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			if (countFrame++ >= waitingTime)
			{
				for (var i:int = 0; i < nbOfCanon; i++)
				{
					
					lPosition = GameLayer.getInstance().globalToLocal(enemyCollider.getChildByName("mcWeapon" + i).localToGlobal(new Point(0, 0)));
					lRadian = enemyCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
					lVelocity = new Point(Math.cos(lRadian) * SHOT_SPEED, Math.sin(lRadian) * SHOT_SPEED);
					lShot = new ShotAlly("ShotAlly", lVelocity);
					
					lShot.x = lPosition.x + 10;
					lShot.y = lPosition.y + 10;
					
					lShot.rotation -= enemyCollider.getChildByName("mcWeapon" + i).rotation;
					
					lShot.scaleX = lShot.scaleY = 0.8;
					
					lShot.cacheAsBitmap = true;
					
					ShotAlly.list.push(lShot);
					
					parent.addChild(lShot);
					lShot.start();
					
					countFrame = 0;
				}
			}
		
		}
		
		override public function destroy():void
		{
			list.removeAt(list.indexOf(this));
			super.destroy();
		}
		
		override public function start():void
		{
			super.start();
			enemyCollider = MovieClip(getChildAt(1));
		}
	
	}

}