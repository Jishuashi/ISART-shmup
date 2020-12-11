package com.isartdigital.shmup.game.layers 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class InfiniteLayer extends ScrollingLayer 
	{
		private const WIDTH_PART : int = 1220;
		private var childList : Vector.<MovieClip> = new Vector.<flash.display.MovieClip>();
		
		public function InfiniteLayer() 
		{
			super();
			nbChild = numChildren;
			
			for (var i:int = 0; i < nbChild; i++) 
			{
				
				childList.push(getChildAt(i));
			}
			
			childList.sort(compareByPosition);
			
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			
			if (childList[0].x + WIDTH_PART < screenLimits.left)
			{
				childList[0].x += 3 * WIDTH_PART;
				childList.push(childList.shift());
			}
		}		
		
	}

}