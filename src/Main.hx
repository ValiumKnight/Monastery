import com.haxepunk.Engine;
import com.haxepunk.HXP;
import worlds.GameWorld;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 1280;
	public static inline var kScreenHeight:Int = 960;
	public static inline var kFrameRate:Int = 60;
	public static inline var kClearColor:Int = 0x333333;
	public static inline var kProjectName:String = "HaxePunk";

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
		HXP.screen.scale = 4;
		HXP.world = new GameWorld();
	}

	public static function main()
	{
		new Main();
	}

}