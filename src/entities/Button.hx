package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;


/**
 * ...
 * @author Pumpkin Eater
 */

class Button extends Entity
{
    private var _sprite: Image;
    
	public static var pressed: Bool = false;

	public function new(x:Int, y:Int)
	{
		super(x, y);
        
        _sprite = new Image("gfx/block.png");
		
		graphic = _sprite;
        
        setHitbox( _sprite.width, _sprite.height );
	}
	
	public override function update()    
	{ 
		if ( ( cast(collide( CollisionType.PLAYER , x , y ) != null ) )|| (
			 cast(collide( CollisionType.PLANT , x , y ) != null ) ) )
		{
			trace("Button pressed");
		}
		else
		{
			trace("");
		}
	}

}