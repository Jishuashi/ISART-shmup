package com.isartdigital.shmup.game.sprites
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import flash.geom.Point;
	import utils.math.MathTools;
	import utils.math.VectorTools;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class Enemy2 extends Enemy
	{
		private var waitTime:int = 120;
		private var counterFrame:int = 0;
		
		
		public var  returnRotation : Boolean = false;
		
		public function Enemy2(pAsset:String)
		{
			super(pAsset);
			nbOfCanon = 6;
			nbOfLife = 25;
			scoreValue = 1000;
			
			waitingTime = 25;
			
			indexOfShot = 2;
			
			canGenerateItems = true;
			
			waitingTime = 150;
		}
		
		override protected function doActionNormal():void
		{			
			var lPos:Point = new Point(Player.getInstance().x - x, Player.getInstance().y - y);
			var lRadian:Number = Math.atan2(lPos.x, lPos.y);
			rotation = -lRadian * MathTools.RAD2DEG - 90;
			
			if (counterFrame++ >= waitTime)
			{
				x -= GameLayer.getInstance().speed;
			}
			
			if (rotation > 90 || rotation < -90)
			{
				scaleY = -1;
				returnRotation = true;
			}
			else
			{
				scaleY = 1;
				returnRotation = false;
			}
			
			doShotNormal();
			
		}
		
		override public function doActionHurt():void
		{
			super.doActionHurt();
			
			doDestroyOutsideOfscreen();
			
			x -= GameLayer.getInstance().speed;
		}
	}

}