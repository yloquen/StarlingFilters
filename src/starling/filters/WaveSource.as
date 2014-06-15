package starling.filters 
{
	import flash.geom.Point;
	public class WaveSource 
	{		
		public static const LINEAR:int = 0;
		public static const RADIAL:int = 1;
		
		public var type:int;
		
		
		public var amplitude:Number;
		public var frequency:Number;	
		
		public var xComponent:Number;	// density on x axis
		public var yComponent:Number;	// density on y axis, no effect on RADIAL sources	
		
		public var origin:Point;		// center of radial waves - relative tex coordinates 0-1
		public var fallOff:Number;		// not used
		public var aspect:Number;		// texture aspect
		
		public var time:Number;
		public var propagation:Number;	// wave propagation speed, 0=instant
		
		
		public function WaveSource(type:int, amplitude:Number = .01, frequency:Number = 5, xComponent:Number = 20, yComponent:Number = 5, origin:Point = null, aspect:Number = 1, propagation:Number=0, fallOff:Number = 0) 
		{			
			this.type = type;
			this.amplitude = amplitude;
			this.frequency = frequency;
			this.xComponent = xComponent;
			this.yComponent = yComponent;
			origin == null ? this.origin = new Point(.5, .5) : this.origin = origin;
			this.aspect = aspect;
			this.fallOff = fallOff;
			this.time = 0;
			this.propagation = propagation;
		}
		
	}

}