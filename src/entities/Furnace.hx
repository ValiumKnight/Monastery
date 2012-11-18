package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import worlds.GameWorld;

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
        
        _sprite = new Image("gfx/furnace_off.png");
		
		graphic = _sprite;
        
        type = CollisionType.FURNACE;
        
        setHitbox( _sprite.width, _sprite.height );
	}
    
    public function burnPlant( )
    {
        _sprite = new Image( "gfx/furnace.png" );
        
        new Sfx( "music/burn_plant.wav" ).play( );
        
        var i:Int = 0;
        
        switch( i )
        {
            case 0:
                new Sfx( "music/burn_plant.wav" ).play( );
            case 1:
                new Sfx( "music/i-don-t-hate-you.mp3" ).play( );
            case 2:
                new Sfx( "music/wooo.mp3" ).play( );
            case 3:
                new Sfx( "music/no-hard-feelings.mp3" ).play( );
        }
        
        i++;
        
        graphic = _sprite;
		

    }
}