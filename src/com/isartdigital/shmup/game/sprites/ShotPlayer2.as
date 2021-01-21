package com.isartdigital.shmup.game.sprites
{
	import flash.geom.Point;
	import utils.math.MathTools;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class ShotPlayer2 extends ShotPlayer
	{
		
		private static var shoot:ShotPlayer2;
		
		public function ShotPlayer2(pAsset:String, pVelocity:Point)
		{
			super(pAsset, pVelocity);
		
		}
		
		override protected function move():void
		{
			super.move();
			
			/*var lShot:ShotPlayer2;
			var lAngle:Number;
			var lPositionOnCircle:Point;
			var lVelocity:Point;
			var lPosition:Point;
			
			const ARC_ANGLE:Number = 120;
			const ARC_RADIUS:Number = 50;
			const SHOT_SPEED:Number = 5;
			const N_SHOT:int = 10;
			var offset:Number = (180 - ARC_ANGLE) / 2;
			
			for (var i:int = 0; i < N_SHOT; i++)
			{
				//lAngle = (offset + ARC_ANGLE * i / (N_SHOT - 1)) * MathTools.DEG2RAD;
				
				if (Player.getInstance().weaponLevel == 2 && list.length > 0)
				{
					shoot = ShotPlayer2(list[i]);
					
					trace()
					
					lAngle = MathTools.lerp(offset, offset + ARC_ANGLE, i / (N_SHOT - 1)) * MathTools.DEG2RAD;					
					lPositionOnCircle = new Point(Math.cos(lAngle) * ARC_RADIUS, Math.sin(lAngle) * ARC_RADIUS);
					lVelocity = new Point(Math.cos(lAngle) * SHOT_SPEED, Math.sin(lAngle) * SHOT_SPEED);
					lPosition = new Point(x + lPositionOnCircle.x, y + lPositionOnCircle.y);
			
					
					shoot.x = lPosition.x;
					shoot.y = lPosition.y;
				}
			}*/
			
			
			x += velocity.x;
			y += velocity.y;
			
		}
	}

}