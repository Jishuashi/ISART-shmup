package com.isartdigital.shmup.game.sprites 
{
	import com.isartdigital.utils.game.StateObject;
	
	/**
	 * Classe Obstacle
	 * Cette classe hérite de la classe StateObject elle possède donc une propriété renderer représentation graphique
	 * de l'obstacle et une propriété collider servant de boite de collision de l'Obstacle
	 * @author Mathieu ANTHOINE
	 */
	public class Obstacle extends StateObject 
	{
		
		public static var list:Vector.<Obstacle> = new Vector.<Obstacle>();
		
		/**
		 * Constructeur de la classe Object
		 * @param	pAsset Nom de la classe du Generateur de l'Obstacle. Ce nom permet d'identifier l'Obstacle et le créer en conséquence
		 */
		public function Obstacle(pAsset:String) 
		{
			assetName = pAsset;
			super();
		}

	}

}