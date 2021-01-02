package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utils.math.MathTools;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Boss extends Enemy
	{
		
		public static var listOfPhase : Vector.<Boss> = new Vector.<Boss>();
		private var phase : int = 0;
		private var nbOfPhase : int = 3;
		public static var boss:Enemy;
		public static var life:int = 100;
		public static var lifeOfNexLevel: int = 0;
		private var waitingTimeBoss:int = 120;
		private var counterFrameBoss:int = 0;
		private var bossCollider:MovieClip;
		private var nbOfCannon:int = 1;
		
		public function Boss(pAsset:String)
		{
			super(pAsset);
			assetName = pAsset;			
			trace(listOfPhase)
			
			scaleX = scaleY = 1;
		}
		
		override protected function doActionNormal():void
		{
			if (boss == null)
			{
				boss = listOfPhase[0];
			}
			
			if (counterFrameBoss++ >= waitingTimeBoss)
			{
				x -= GameLayer.getInstance().speed;
			}
			
			if (life <= 50)
			{
				lifeOfNexLevel = life;
				setState("explosion");
				
				if(isAnimEnd())
				{
					destroy();
					boss.start();
					bossCollider = MovieClip(getChildAt(1));
					life = lifeOfNexLevel;
					GameLayer.getInstance().addChild(boss)
					nbOfCannon = 5;
					doAction = doSetSecondPhase;
				}	
			}
			
			doShotNormalBoss();
		
		}
		
		
		public function doSetSecondPhase():void 
		{
			x -= GameLayer.getInstance().speed;
			
			
			doShotNormalBoss();
		}
		
		public function doActionHurtBoss():void
		{
			setState("hurt")
			
			x -= GameLayer.getInstance().speed;
			
			if (isAnimEnd())
			{
				life -= Player.getInstance().weaponDamage;
				setState("default")
				doAction = doActionNormal;
			}
		}
		
		private function doShotNormalBoss():void
		{
			var lShot:ShotBoss;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			if (countFrame++ >= waitingTime)
			{
				for (var i:int = 0; i < nbOfCanon; i++)
				{
					
					lPosition = GameLayer.getInstance().globalToLocal(bossCollider.getChildByName("mcWeapon" + i).localToGlobal(new Point(0, 0)));
					lRadian = bossCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
					lVelocity = new Point(Math.cos(lRadian) * SHOT_SPEED, Math.sin(lRadian) * SHOT_SPEED);
					lShot = new ShotBoss("ShotBoss", lVelocity);
					
					lShot.x = lPosition.x;
					lShot.y = lPosition.y;
					
					lShot.rotation = bossCollider.getChildByName("mcWeapon" + i).rotation;
					
					lShot.scaleX = lShot.scaleY = 0.8;
					
					lShot.cacheAsBitmap = true;
					
					ShotBoss.list.push(lShot);
					
					parent.addChild(lShot);
					lShot.start();
					countFrame = 0;
				}
			}
		
		}
		
		override public function start():void
		{
			super.start();
			bossCollider = MovieClip(getChildAt(1));
		}
		
		override public function destroy():void 
		{
			listOfPhase.removeAt(listOfPhase.indexOf(this));
			super.destroy();
			
		}
		
	}

}