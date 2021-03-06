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
import worlds.GameWorld;

/**
 * ...
 * @author ValiumKnight
 */

class GravityPoint extends Entity
{
    private var _sprite_on: Image;
    private var _sprite_off: Image;
    private var _sprite_b_on: Image;
    private var _sprite_b_off: Image;
    
    public var radius:Int;
    
    public var circle:Entity;
    
    public var enabled:Bool;
    
    private var gravityEmitter:Emitter;
    
    private var gravityOnSfx:Sfx;
	
	private var count:Int;
    
    private var up:Bool = false;
    

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        radius = 60;
        
        count = Std.int( Math.random( ) * 20 );
        
        _sprite_on = new Image("graphics/gravity_point_on.png");
        _sprite_off = new Image("graphics/gravity_point_off.png");
        _sprite_b_on = new Image("graphics/gravity_point_b_on.png");
        _sprite_b_off = new Image("graphics/gravity_point_b_off.png");
        
        gravityOnSfx = new Sfx( "sfx/gravity_on.wav" );
        
        type = CollisionType.GRAVITY_POINT;
        
        setHitbox( Std.int( _sprite_on.width ), Std.int( _sprite_on.height ) );
        
        gravityEmitter = new Emitter(new BitmapData(2, 2), 3, 3);
        
        graphic = new Graphiclist( );
        
        cast( graphic, Graphiclist ).add( _sprite_off );
        cast( graphic, Graphiclist ).add( gravityEmitter );
        
        // Define our particles
        gravityEmitter.newType("explode",[0]);
        gravityEmitter.setAlpha("explode",1,0);
        gravityEmitter.setMotion("explode", 0, radius, 4, 360, -40, -0.5, Ease.quadOut );
        gravityEmitter.setColor("explode", 0xa4639e, 0xff00ff );
        gravityEmitter.relative = false;
	}
	
	public override function update()
    {
        super.update();
        
        if ( enabled )
        {
            cast( graphic, Graphiclist ).removeAll( );
            
            if ( this == GameWorld.button_gp )
            {
                cast( graphic, Graphiclist ).add( _sprite_b_on );
                gravityEmitter.setColor("explode", 0x1EEA37, 0x649B6C );
            }
            else
            {
                cast( graphic, Graphiclist ).add( _sprite_on );
                gravityEmitter.setColor("explode", 0xa4639e, 0xff00ff );
            }
            cast( graphic, Graphiclist ).add( gravityEmitter );
            gravityEmitter.emit("explode", x + width / 2, y + height / 2);
        }
        else
        {
            cast( graphic, Graphiclist ).removeAll( );
            if ( this == GameWorld.button_gp )
            {
                cast( graphic, Graphiclist ).add( _sprite_b_off );
            }
            else
            {
                cast( graphic, Graphiclist ).add( _sprite_off );
            }
        }
        
        if ( count % 6 == 0 )
        {
            y = up? y + 1 : y - 1;
        }
        
        if ( count == 40 )
        {
            up = !up;
            count = 0;
        }
        
        count++;
    }
    
    public function toggle( )
    {
        enabled = !enabled;
        gravityOnSfx.play( );
    }
}