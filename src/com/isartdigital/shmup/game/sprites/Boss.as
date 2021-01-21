package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.ui.UIManager;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.game.StateObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import utils.math.MathTools;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Boss extends Enemy
	{
		public static var changePhase:Boolean = false;
		public var phaseIndent:Boolean = false;
		//public static var list: Vector.<Boss> = new Vector.<Boss>();
		
		private var bossCollider:MovieClip;
		
		private var speedBoss:Number = GameLayer.getInstance().speed;
		
		public var phase:int = 0;
		
		private var lastPos:Point;
		
		public var life:int = 1;
		
		private var waitingTimeBoss:int = 90;
		private var waitingTimeBoss2:int = 100;
		private var waitingTimeBoss3:int = 100;
		private var counterFrameBoss:int = 0;
		private var counterFrameBoss3:int = 0;
		private var counterFrameBoss2:int = 0;
		
		public function Boss(pAsset:String)
		{
			assetName = pAsset;
			super(pAsset);
			
			bossCollider = MovieClip(getChildAt(1));
			
			//list.push(this);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			scaleX = scaleY = 1.2;
		}
		
		override protected function doActionNormal():void
		{
			if (counterFrameBoss++ >= waitingTimeBoss)
			{
				x -= speedBoss;
			}
			
			if (life <= 0)
			{
				changePhase = true;
				setPhaseChange();
			}
			
			doShotNormal();
		}
		
		public function init(pEvent:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			switch (phase)
			{
			case 0: 
				nbOfCanon = 1;
				life = 50;
				break;
			case 1: 
				nbOfCanon = 3;
				life = 25;
				doAction = doSecondPhase;
				break;
			case 2: 
				nbOfCanon = 5;
				life = 25;
				doAction = doThirdPhase;
				break;
			}
		}
		
		public function setPhaseChange():void
		{
			setState("explosion");
			
			if (renderer.currentFrame == 1 && !phaseIndent)
			{
				
				if (phase < 3)
				{
					phase++;
				}
				else
				{
					return;
				}
				
				phaseIndent = true;
				
				trace(phase);
				
				var lNextBoss:Boss = new Boss("Boss" + (phase));
				
				x = lNextBoss.x;
				
				lastPos = new Point(x, y);
				
				lNextBoss.x = lastPos.x;
				lNextBoss.y = lastPos.y;
				
				lNextBoss.phase = phase;
				
				lNextBoss.start();
				
				trace("Boss Actuelle " + x + " // " + y)
				trace("Boss Suivant " + lNextBoss.x + " // " + lNextBoss.y)
				
				
				GameLayer.getInstance().addChildAt(lNextBoss, GameLayer.getInstance().getChildIndex(this));
				
			}
			else if (isAnimEnd())
			{
				changePhase = false;
				
				GameManager.boss0Loop.fadeOut();
				GameManager.boss1Loop.fadeIn();
				
				phaseIndent = false;
				
				trace("Je suis fini" + phase);
				
				destroy();
			}
		
		}
		
		public function doSecondPhase():void
		{
			x -= speedBoss;
			
			if (life <= 0)
			{
				changePhase = true;
				setPhaseChange();
			}
			
			if (!phaseIndent) doShotNormal();
		}
		
		public function doThirdPhase():void
		{
			
			x -= speedBoss;
			
			if (life <= 0)
			{
				GameManager.win();
				doAction = doActionVoid;
			}
			
			doShotNormal();
		}
		
		override protected function doShotNormal():void
		{
			var lShot:ShotBoss;
			var lPosition:Point;
			var lRadian:Number;
			var lVelocity:Point;
			
			if (counterFrameBoss2++ >= waitingTimeBoss2)
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
					
					GameLayer.getInstance().addChild(lShot);
					lShot.start();
					counterFrameBoss2 = 0;
				}
			}
		
		}
		
		public function doActionHurtBoss():void
		{
			setState("hurt");
			x -= speedBoss;
			
			if (isAnimEnd())
			{
				life -= Player.getInstance().weaponDamage;
				setState("default");
				
				if (phase == 0) doAction = doActionNormal;
				if (phase == 1) doAction = doSecondPhase;
				if (phase == 2) doAction = doThirdPhase;
			}
		}
		
		override public function destroy():void
		{
			//list.removeAt(list.indexOf(this));
			removeEventListener(Event.ADDED_TO_STAGE, init);
			super.destroy();
		}
	}

}