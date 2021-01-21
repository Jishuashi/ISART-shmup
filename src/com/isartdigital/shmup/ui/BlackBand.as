package com.isartdigital.shmup.ui
{
	import com.isartdigital.shmup.game.GameManager;
	import com.isartdigital.utils.Config;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class BlackBand extends MovieClip
	{
		
		private var counterFrame:int = 0;
		private var waitinTime:int = 300;
		
		public function BlackBand()
		{
			super();
		
		}
		
		public function move():void
		{
			if (counterFrame++ <= waitinTime)
			{
				if (y > Config.stage.stageHeight / 2)
				{
					y += 2;
				}
				else
				{
					y -= 2;
				}
			}
			else
			{
				GameManager.startOn = false;
				destroy();
			}
		}
		
		protected function destroy():void
		{
			if (parent != null) parent.removeChild(this);
		}
	}

}