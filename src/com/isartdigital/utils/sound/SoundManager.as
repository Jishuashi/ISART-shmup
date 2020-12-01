package com.isartdigital.utils.sound 
{
	import com.isartdigital.shmup.Shmup;
	import com.isartdigital.utils.Config;
	import com.isartdigital.utils.loader.AssetsLoader;
	import com.isartdigital.utils.sound.SoundFX;
	import flash.events.Event;
    import flash.media.Sound;
    import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Mathieu ANTHOINE
	 */
	public class SoundManager 
	{
		
		/**
		 * instance unique de la classe SoundManager
		 */

		protected static var isInit:Boolean;
		protected static var soundNamesToSoundsDef:Object = {};
		
		public function SoundManager() 
		{
			
		}
		
		/**
		 * Créé les instances de chaque son et les stock en interne pour les rendre accessible via getSound
		 */
		protected static function init():void{
			if (isInit) return;
			
			isInit = true;
			
			var lJson : Object = JSON.parse(AssetsLoader.getContent(Shmup.SOUND_PATH).toString());
			SoundFX.mainVolume	=	lJson.volumes.master * int(Config.mainSound);
			
			var i:String;
			
			// FXS
			var lFxs : Object = lJson.files.fxs;

			for (i in lFxs) {
                soundNamesToSoundsDef[i] = {
                    volume : (lFxs[i].volume) * lJson.volumes.fxs,
                    sound  : Sound(new (Class(getDefinitionByName(lFxs[i].asset)))())
                };
			}
			
			// MUSICS
			var lMusics : Object = lJson.files.musics;
			
			for (i in lMusics) {
                soundNamesToSoundsDef[i] = {
                    volume : (lMusics[i].volume) * lJson.volumes.musics,
                    sound  : Sound(new (Class(getDefinitionByName(lMusics[i].asset)))())
                };
			}
		}
		
		/**
		 * retourne une nouvelle référence de SoundFX par l'intermédiaire de son identifiant
		 * @param	pName identifiant du son
		 * @return le son
		 */
		public static function getNewSoundFX(pName:String): SoundFX {
			if (!isInit) init();
			
            var lSoundDef:Object = soundNamesToSoundsDef[pName];

            if (lSoundDef == null)
                throw new Error("\rL'identifiant " + pName + " de son n'existe pas dans la liste de son !");
            
            return new SoundFX(lSoundDef.sound, lSoundDef.volume);
		}
		
		/**
		 * Stoppe l'intégralité des sons
		 */
		public static function stopSounds():void{
            for (var i:int = SoundFX.list.length - 1; i >-1; i--){
                SoundFX.list[i].stop();
            }
		}
	}
}