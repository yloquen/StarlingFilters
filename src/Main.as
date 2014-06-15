package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;	
	
	/**
	 * ...
	 * @author kizzo
	 */

	[SWF(width='1200', height='900', backgroundColor='0x000000', frameRate='60')]
	public class Main extends Sprite 
	{		


		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}


		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var s:Starling = new Starling(FilterDemo, stage);
			s.start();
		}
		
	}
	
}