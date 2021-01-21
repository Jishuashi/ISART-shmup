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
	public class ShotPlayer1 extends ShotPlayer
	{
		
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		
		public function ShotPlayer1(pAsset:String, pVelocity:Point)
		{
			super(pAsset, pVelocity);
		
		}
		
		override protected function move():void
		{
			
			rotation += 0.5;
			
			y -= Math.sin(speedY * MathTools.DEG2RAD) * 1;
			speedY += 0.5;
			
			x -= GameLayer.getInstance().speed * speedX;
			speedX += 0.1;
		
		}
	}
}