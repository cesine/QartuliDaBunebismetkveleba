﻿package
{
	
	import flash.display.MovieClip;
	import com.greensock.*
	import com.greensock.easing.*
	import flash.events.DataEvent;
	import flash.events.Event;
	
	public class GatenebaClass extends MovieClip
	{
		private var gateneba:MovieClip;
		private var soundControl:SoundControl;
		
		private var _stageHeight:Number;
		private var _stageWidth:Number;
		
		public function GatenebaClass(_stageHeight, _stageWidth)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			if (gateneba)
			{
				removeChild(gateneba);
				gateneba = null;
			}
			
		    TweenMax.killTweensOf(gateneba);
		
		}
		
		private function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addObjects();
		}
		private function addObjects():void
		{
			gateneba = new Gateneba();
			
			gateneba.x = _stageWidth / 2;
			gateneba.y = _stageHeight / 2;
			
			gateneba.height = _stageHeight / 1.2;
			gateneba.scaleX = gateneba.scaleY;
			
			gateneba.alpha = 0;
			addChild(gateneba);
			animMuseum2();
		}
		private function animMuseum2():void
		{
			soundControl = new SoundControl();
			addChild(soundControl);
			//soundControl.addEventListener(DataEvent.DATA, soundListener);
			soundControl.loadSound("6.mp3", 1);
			soundControl.soundPlay();
			TweenMax.to(gateneba, 1, { alpha:1, onComplete:sceneIsFinished } );
		}
		private function soundListener(e:DataEvent):void 
		{
			soundControl.removeEventListener(DataEvent.DATA, soundListener);
			removeChild(soundControl);
			soundControl = null;
			
			soundControl = new SoundControl();
			//addChild(soundControl);
			//soundControl.loadSound("muzeumi_09_page_02.mp3", 1);
			//soundControl.soundPlay()
			
		}
		public function gasvla():void
		{
			soundControl.soundStop();
			TweenMax.to(gateneba, 1, { alpha:0 } );
			destroy(null);
		}
		private function sceneIsFinished():void 
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "movrchi scenas"));
		}
	}

}
