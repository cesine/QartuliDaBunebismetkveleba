﻿package
{
	
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.greensock.*;
	import flash.utils.setTimeout;
	import flash.ui.Mouse;
	
	public class Action32 extends MovieClip
	{
		private var earthColor:MovieClip;
		private var color:ColorTransform;
		private var count:Number = 0;
		private var _Width:Number;
		private var _Height:Number;
		private var colorName:String;
		private var bool1:Boolean = false;
		private var bool2:Boolean = false;
		private var soundControl1:SoundControl;
		
		
		private var old_X:Number;
		private var old_Y:Number;
		
		public function Action32(_Width:Number = 1024, _Height:Number = 800)
		{
			this._Height = _Height;
			this._Width = _Width;
			addEventListener(Event.ADDED_TO_STAGE, init)
			addEventListener(Event.REMOVED_FROM_STAGE, Destroy);
		}
		
		private function Destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, Destroy);
			earthColor.wathercolor.removeEventListener(MouseEvent.MOUSE_DOWN, getColor)
			earthColor.landcolor.removeEventListener(MouseEvent.MOUSE_DOWN, getColor)
			
			earthColor.wather.removeEventListener(MouseEvent.MOUSE_DOWN, changeColor)
			earthColor.land.removeEventListener(MouseEvent.MOUSE_DOWN, changeColor)
			if (earthColor)
			{
				removeChild(earthColor)
				earthColor = null;
			}
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initHandler();
		}
		
		private function initHandler():void
		{
			earthColor = new EarthColor();
			earthColor.x = _Width / 2;
			earthColor.y = _Height / 2;
			earthColor.height = _Height / 1.5;
			earthColor.scaleX = earthColor.scaleY;
			addChild(earthColor);
			//#00558C wather // #E6BB57 earthcolor;
			
			earthColor.wathercolor.addEventListener(MouseEvent.MOUSE_DOWN, getColor)
			earthColor.landcolor.addEventListener(MouseEvent.MOUSE_DOWN, getColor)
			
			earthColor.wather.addEventListener(MouseEvent.MOUSE_DOWN, changeColor)
			earthColor.land.addEventListener(MouseEvent.MOUSE_DOWN, changeColor)
			earthColor.colortrans.addEventListener(MouseEvent.MOUSE_DOWN, changePointClick);
			old_X = earthColor.closebox.x;
			old_Y = earthColor.closebox.y;
			earthColor.closebox.addEventListener(MouseEvent.MOUSE_DOWN, closeBoxFunc);
		}
		private function closeBoxFunc(e:MouseEvent):void
		{
		
			earthColor.colortrans.x = old_X;
			earthColor.colortrans.y = old_Y;
			Mouse.show();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function changePointClick(e:MouseEvent):void
		{
			
			//Mouse.hide();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(ev:MouseEvent):void
		{
			try
			{
				earthColor.colortrans.x = ev.stageX - earthColor.width / 2 - earthColor.colortrans.width / 2.5-30;
				earthColor.colortrans.y = ev.stageY - earthColor.height / 2 - earthColor.colortrans.height*1.5-55;
			}
			catch (e:Error )
			{
				
			}
			
		}
		
		private function changeColor(e:MouseEvent):void
		{
			
			switch (e.currentTarget.name)
			{
				case "wather": 
					if (colorName == "wathercolor")
					{
						earthColor.wather.transform.colorTransform = color;
						bool1 = true;
						TheEnd();
					}
					else {
					var sound:SoundControl  = new SoundControl();
					addChild(sound)
					sound.loadSound("error.mp3", 1);
					sound.soundPlay();
					}
					break;
				case "land": 
					if (colorName == "landcolor")
					{
						earthColor.land.transform.colorTransform = color;
						bool2 = true;
						TheEnd();
					}
					else {
					var sound1:SoundControl  = new SoundControl();
					addChild(sound1)
					sound1.loadSound("error.mp3", 1);
					sound1.soundPlay();
					}
					break;
			}
		}
		
		private function TheEnd():void
		{
			if (bool1 && bool2)
			{
				soundControl1 = new SoundControl();
				addChild(soundControl1);
				soundControl1.loadSound("correct.mp3", 1);
				soundControl1.soundPlay();
				setTimeout(NextStage, 3000);
				
			}
		}
		
		private function NextStage():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfStage"));
			Destroy(null);
		}
		
		private function getColor(e:MouseEvent):void
		{
			switch (e.currentTarget.name)
			{
				case "wathercolor": 
					colorName = e.currentTarget.name
					color = new ColorTransform();
					color.color = 0x00558C;
					colors()
					break;
				case "landcolor": 
					colorName = e.currentTarget.name
					color = new ColorTransform();
					color.color = 0xE6BB57;
					colors();
					break;
			
			}
		}
		
		private function colors():void
		{
			earthColor.colortrans.showColor.transform.colorTransform = color;
		}
	}

}
