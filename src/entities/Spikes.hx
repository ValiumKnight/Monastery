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
        
        type = CollisionType.STATIC_SOLID;
        
        setHitbox( _sprite.width, _sprite.height );
	}
}