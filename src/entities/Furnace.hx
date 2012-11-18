package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Pumpkin Eaters
 */

class Furnace extends Entity
{
    private var _sprite: Image;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        _sprite = new Image("gfx/furnace.png");
		
		graphic = _sprite;
        
        type = CollisionType.FURNACE;
        
        setHitbox( _sprite.width, _sprite.height );
	}
    
    public function burnPlant( )
    {
        _sprite = new Image( "gfx/furnace.png" );
        
        new Sfx( "music/i-don-t-blame-you.mp3" ).play( );
        
        new Sfx( "music/burn_plant.wav" ).play( );
        
        graphic = _sprite;
    }
}