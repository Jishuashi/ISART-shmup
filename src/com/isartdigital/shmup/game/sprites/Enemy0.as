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
	public class Enemy0 extends Enemy 
	{
		public function Enemy0(pAsset:String) 
		{
			super(pAsset);
			nbOfCanon = 1;
			
			indexOfShot = 0;
			
			nbOfLife = 1;
			
			waitingTime = 60;
			
			scoreValue = 100;
			canGenerateItems = true;
		}
		
		override protected function move():void 
		{
			
			doDestroyOutsideOfscreen();
			
			y -= Math.sin(speedY * MathTools.DEG2RAD) * 5;
			speedY += 2;
			
			
			x += GameLayer.getInstance().speed * speedX;
			speedX += 0.5;
		}
		
	}

}