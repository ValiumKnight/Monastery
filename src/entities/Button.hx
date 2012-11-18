package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import worlds.GameWorld;

/**
 * ...
 * @author Pumpkin Eater
 */

class Button extends Entity
{
    private var _sprite_on: Image;
    private var _sprite_off: Image;
    
	public static var pressed: Bool = false;

	public function new(x:Int, y:Int)
	{
		super(x, y);
        
        _sprite_off = new Image("gfx/up_button.png");
		_sprite_on = new Image("gfx/down_button.png");
		
		graphic = _sprite_off;
        setHitbox( _sprite_off.width, _sprite_off.height );
	}
	
	public override function update()    
	{ 
		if ( ( cast(collide( CollisionType.PLAYER , x , y ) != null ) )|| (
			 cast(collide( CollisionType.PLANT , x , y ) != null ) ) )
		{
			if ( GameWorld.button_gp != null ) {
				GameWorld.button_gp.enabled = true;
				graphic = _sprite_on;
				setHitbox( _sprite_on.width, _sprite_on.height );
			}
		}
		else
		{
			if ( GameWorld.button_gp != null ) {
				GameWorld.button_gp.enabled = false;
				graphic = _sprite_off;
				setHitbox( _sprite_off.width, _sprite_off.height );
				
			}
		}
	}

}