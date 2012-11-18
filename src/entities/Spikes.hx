package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author me
 */

class Spikes extends Entity
{
    private var _sprite: Image;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        _sprite = new Image("gfx/spikes.png");
		
		graphic = _sprite;
		
		setHitbox( 23, 32);
	}
	
	public override function update()    
	{ 
		var player:Player = cast(collide( CollisionType.PLAYER , x , y ), Player);
		
		if ( player != null )
		{	      
			player.x = 100;
			player.y = 50;
			trace("colliding with spikes");
		}
	}
}