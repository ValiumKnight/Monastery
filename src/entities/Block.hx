package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Rob Filippi
 */

class Block extends Entity
{
    private var _sprite: Image;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        _sprite = new Image("gfx/block.png");
		
		graphic = _sprite;
        
        type = CollisionType.STATIC_SOLID;
        
        setHitbox( _sprite.width, _sprite.height );
	}
	
	public override function update()
    {
        super.update();
    }
}