package com.isartdigital.shmup.game.sprites
{
	import com.greensock.easing.Power0;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.levelDesign.EnemyGenerator;
	import com.isartdigital.shmup.ui.hud.Hud;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
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
		protected var scoreValue: int ;
		protected var waitingTime:int = 60;
		protected var countFrame:int = 0;
		protected var speed:int = 5;
		protected var nbOfLife:int;
		protected var durationInFrame:int;
		protected var enemyCollider:MovieClip;
		
		public function Enemy(pAsset:String)
		{
			assetName = pAsset;
			super();
			scaleX = scaleY = 0.8;
		}
		
		override protected function doActionNormal():void
		{
			super.doActionNormal();
			
			doShotNormal();
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
			
			if (countFrame++ >= waitingTime)
			{
				for (var i:int = 0; i < nbOfCanon; i++)
				{
					
					lPosition = GameLayer.getInstance().globalToLocal(enemyCollider.getChildByName("mcWeapon" + i).localToGlobal(new Point(0, 0)));
					lRadian = enemyCollider.getChildByName("mcWeapon" + i).rotation * MathTools.DEG2RAD;
					lVelocity = new Point(Math.cos(lRadian) * SHOT_SPEED, Math.sin(lRadian) * SHOT_SPEED);
					lShot = new ShotEnemy("ShotEnemy" + indexShotAsset, lVelocity);
					
					lShot.x = lPosition.x;
					lShot.y = lPosition.y;
					
					lShot.rotation = enemyCollider.getChildByName("mcWeapon" + i).rotation;
					
					lShot.scaleX = lShot.scaleY = 0.8;
					
					lShot.cacheAsBitmap = true;
					
					ShotEnemy.list.push(lShot);
					
					parent.addChild(lShot);
					lShot.start();
					countFrame = 0;
				}
			}
		
		}
		
		public function doDestroy()
		{
			nbOfLife--;
			
			if (0 >= nbOfLife)
			{
				doAction = doExplosion;
			}
			else
			{
				if (state != "hurt")
				{
					doAction = doActionHurt;
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