package
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.ChromaticAberrationFilter;
	import starling.filters.ShineFilter;
	import starling.textures.Texture;

	public class FilterDemo extends Sprite
	{
/*		[Embed(source = "../img/img.jpg")]
		private var WaveImage:Class;*/

		[Embed(source = "../img/logo.png")]
		private var LogoImage:Class;


		public function FilterDemo()
		{
			var tex:Texture = Texture.fromBitmap(new LogoImage());
			var framed_tex:Texture = Texture.fromTexture(tex, null, new Rectangle( -50, -50, tex.width + 100, tex.height + 100));
			var img1:Image = new Image(framed_tex);
			addChild(img1);

			var caf:ChromaticAberrationFilter = new ChromaticAberrationFilter();
			caf.intensity = 5;
			img1.filter = caf;

			TweenMax.to(caf, 2, {angle:Math.PI*2, repeat:-1, ease:Linear.easeNone});




			var tex:Texture = Texture.fromBitmap(new LogoImage());
			var framed_tex:Texture = Texture.fromTexture(tex, null, new Rectangle( -50, -50, tex.width + 100, tex.height + 100));
			var img2:Image = new Image(framed_tex);
			addChild(img2);

			var f:ShineFilter = new ShineFilter();
			f.rgbTint = Vector.<Number>([1,1,.7]);
			img2.filter = f;
			img2.y = img1.bounds.bottom;
			TweenMax.to (f, 5, {position:-2, ease:Cubic.easeInOut, repeat:-1});
			TweenMax.to (f,.4, {intensity:.5, yoyo:true, repeat:1});
		}


	}

}