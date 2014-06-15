package starling.filters
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;

	import starling.textures.Texture;

	public class ChromaticAberrationFilter extends FragmentFilter
    {
        private var mShaderProgram:Program3D;	

		private var constants:Vector.<Number>;

	    private var _program:String;

		private var _intensity:Number;
		private var _angle:Number;


	    public function get program():String{ return _program; }
	    public function set program(value:String):void{ _program=value + "\n"; }


        public function ChromaticAberrationFilter()
        {
	        this.constants = new Vector.<Number>(4);
	        _intensity = 0;
	        _angle = 0;
            super();			
        }

        
        override protected  function createPrograms():void
        {
	        program = "tex ft0, v0, fs0 <2d, clamp, linear, mipnone>";

	        program += "add ft3.xyzw, fc0.xyzw, v0.xyxy";

	        program += "tex ft1, ft3.xy, fs0 <2d, clamp, linear, mipnone>";
	        program += "tex ft2, ft3.zw, fs0 <2d, clamp, linear, mipnone>";

	        program += "mov ft0.x, ft1.x";
	        program += "mov ft0.z, ft2.z";

	        program += "mov oc, ft0";

	        mShaderProgram = assembleAgal(program);
        }

        
        protected override function activate(pass:int, context:Context3D, texture:Texture):void
        {
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, this.constants, int(this.constants.length/4));
            context.setProgram(mShaderProgram);			
        }


		public function set intensity(value:Number):void
		{
			_intensity = value/1000;

			var x:Number = _intensity*Math.cos(_angle);
			var y:Number = -_intensity*Math.sin(_angle);

			this.constants[0] = x;
			this.constants[1] = y;
			this.constants[2] = -x;
			this.constants[3] = -y;
		}


		public function get intensity():Number
		{
			return _intensity;
		}


	    public override function dispose():void
	    {
		    if (mShaderProgram) mShaderProgram.dispose();
		    super.dispose();
	    }


		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			var x:Number = _intensity*Math.cos(_angle);
			var y:Number = -_intensity*Math.sin(_angle);

			this.constants[0] = x;
			this.constants[1] = y;
			this.constants[2] = -x;
			this.constants[3] = -y;

			_angle=value;
		}
	}
}