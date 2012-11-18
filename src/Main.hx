import com.haxepunk.Engine;
import com.haxepunk.HXP;
import worlds.Intro;
import com.haxepunk.Sfx;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 480;
	public static inline var kScreenHeight:Int = 360;
	public static inline var kFrameRate:Int = 60;
	public static inline var kClearColor:Int = 0x333333;

	public function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);
	}

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
		HXP.world = new Intro();
        
        new Sfx( "music/steve_counting-sheep-01-320.mp3" ).loop( );
	}
}