package com.isartdigital.shmup.game.levelDesign
{
	import com.isartdigital.shmup.game.layers.GameLayer;
	import com.isartdigital.shmup.game.sprites.Collectable;
	import com.isartdigital.shmup.game.sprites.CollectableFirePower;
	import com.isartdigital.shmup.game.sprites.CollectableFireUpgrade;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Hugo CHARTIER
	 */
	public class CollectableGenerator extends GameObjectGenerator
	{
		
		public static var listOfCollectablesGenerate:Vector.<Collectable> = new Vector.<com.isartdigital.shmup.game.sprites.Collectable>();
		
		public function CollectableGenerator()
		{
			super();
		
		}
		
		override public function generate():void
		{
			
			var lNum:String = getQualifiedClassName(this).substr(-1);
			var lCollectable = Collectable;
			
			switch (lNum)
			{
			case "0": 
				lCollectable = new CollectableFireUpgrade("CollectableFireUpgrade");
				lCollectable.start();
				break;
			case "1": 
				lCollectable = new CollectableFirePower("CollectableFirePower");
				lCollectable.start();
				break;
			default: 
				trace("Error");
				break;
			}
			
			
			listOfCollectablesGenerate.push(lCollectable);
			
			trace(listOfCollectablesGenerate)
			
			lCollectable.x = x;
			lCollectable.y = y;
			
			lCollectable.cacheAsBitmap = true;
			
			GameLayer.getInstance().addChild(lCollectable);
			
			super.generate();
		}
	
	}

}