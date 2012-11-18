package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.Sfx;
import flash.display.BitmapData;
import com.haxepunk.utils.Ease;
import com.haxepunk.graphics.Graphiclist;

/**
 * ...
 * @author ValiumKnight
 */

class GravityPoint extends Entity
{
    private var _sprite: Spritemap;
    
    public var radius:Int;
    
    public var circle:Entity;
    
    public var enabled:Bool;
    
    private var gravityEmitter:Emitter;
    
    private var gravityOnSfx:Sfx;
	
	public static var count = 0;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        radius = 20;
        
        _sprite = new Spritemap("gfx/block.png");
        
        _sprite.scale = 0.5;
        
        gravityOnSfx = new Sfx( "music/gravity_on.wav" );
        
        circle = new Entity( x - radius*3 + _sprite.width / 4, y - radius*3 + _sprite.height / 4 );
        
        var circle_image:Image = Image.createCircle(radius*3, 660066);
        
        circle_image.alpha = 0.4;
        
        circle.graphic = circle_image;
        
        type = CollisionType.GRAVITY_POINT;
        
        setHitbox( Std.int( _sprite.width * _sprite.scale ), Std.int( _sprite.height * _sprite.scale ) );
		
		graphic = _sprite;
        
        gravityEmitter = new Emitter(new BitmapData(2, 2), 3, 3);
        
        graphic = new Graphiclist( );
        
        cast( graphic, Graphiclist ).add( _sprite );
        cast( graphic, Graphiclist ).add( gravityEmitter );
        
        // Define our particles
        gravityEmitter.newType("explode",[0]);
        gravityEmitter.setAlpha("explode",1,0);
        gravityEmitter.setMotion("explode", 0, 50, 4, 360, -40, -0.5, Ease.quadOut );
        gravityEmitter.setColor("explode", 0xa4639e, 0xff00ff );
        gravityEmitter.relative = false;
	}
	
	public override function update()
    {
        super.update();
        
        if ( enabled )
        {
            gravityEmitter.emit("explode",x + width/2, y+ height/2);
        }
    }
    
    public function toggle( )
    {
        enabled = !enabled;
        gravityOnSfx.play( );
    }
}