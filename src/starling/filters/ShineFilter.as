package starling.filters
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;

	import starling.textures.Texture;

	public class ShineFilter extends FragmentFilter
	{
		private var mShaderProgram:Program3D;

		private var constants:Vector.<Number>;

		private var _program:String;



		public function get program():String{ return _program; }
		public function set program(value:String):void{ _program=value + "\n"; }


		public function ShineFilter()
		{
			this.constants = Vector.<Number>([  1,0,-.005,0,            // a, -b, -2*c^2
												1,1,1,0]);             // color mods
			super();
		}


		override protected  function createPrograms():void
		{
			program = "tex ft0, v0, fs0 <2d, clamp, linear, mipnone>";

			program += "add ft1.x, v0.x, v0.y";     // x+y
			program += "add ft1.x, ft1.x, fc0.y";   // x+y-b
			program += "mul ft1.x, ft1.x, ft1.x";   // (x+y-b)^2
			program += "div ft1.x, ft1.x, fc0.z";   // (x+y-b)^2/-2*c*c
			program += "exp ft1.x, ft1.x";          // exp ((x+y-b)^2/-2*c*c)
			program += "mul ft1.x, ft1.x, fc0.x";   // a * exp ((x+y-b)^2/-2*c*c)

			program += "mul ft2.xyz, ft1.xxx, ft0.xyz";     //calc color mods
			program += "mul ft2.xyz, ft2.xyz, fc1.xyz";     //calc color mods

			program += "add ft0.xyz, ft0.xyz, ft2.xyz";   // apply color mods
			program += "mul ft0.xyz, ft0.xyz, ft0.www";   // remove shine where alpha is zero

			program += "mov oc, ft0";

			mShaderProgram = assembleAgal(program);
		}


		protected override function activate(pass:int, context:Context3D, texture:Texture):void
		{
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, this.constants, int(this.constants.length/4));
			context.setProgram(mShaderProgram);
		}


		public override function dispose():void
		{
			if (mShaderProgram) mShaderProgram.dispose();
			super.dispose();
		}


		public function set position(value:Number):void
		{
			constants[1] = value;
		}


		public function get position():Number
		{
			return constants[1];
		}


		public function get intensity():Number
		{
			return constants[0];
		}

		public function set intensity(value:Number):void
		{
			constants[0]=value;
		}


		public function set rgbTint(rgbVals:Vector.<Number>):void
		{
			constants[4] = rgbVals[0];
			constants[5] = rgbVals[1];
			constants[6] = rgbVals[2];
		}


		public function get rgbTint():Vector.<Number>
		{
			return constants.slice(4,3);
		}
	}
}
