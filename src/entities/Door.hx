package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Rob Filippi
 */

class Door extends Entity
{
    private var _sprite: Image;
	public static var locked: Bool = true;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        _sprite = new Image("gfx/door.png");
		
		graphic = _sprite;
        
        type = CollisionType.STATIC_SOLID;
        
        setHitbox( _sprite.width, _sprite.height );
	}
	public function unlock()
	{
		_sprite = new Image("gfx/door_open.png");
		
		graphic = _sprite;
		
		locked = false;
	}
}