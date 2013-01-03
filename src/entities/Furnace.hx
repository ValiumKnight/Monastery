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
        
        _sprite = new Image("graphics/furnace_off.png");
		
		graphic = _sprite;
        
        type = CollisionType.FURNACE;
        
        setHitbox( _sprite.width, _sprite.height );
	}
    
    public function burnPlant( )
    {
        _sprite = new Image( "graphics/furnace.png" );
        
        new Sfx( "sfx/burn_plant.wav" ).play( );
        
        var i:Int = Std.int( Math.random( )*3 );
        
        switch( i )
        {
            case 0:
                new Sfx( "sfx/Zombie1.mp3" ).play( );
            case 1:
                new Sfx( "sfx/hate 2.wav" ).play( );
            case 2:
                new Sfx( "sfx/Pop.mp3" ).play( );          
            case 3:
                new Sfx( "sfx/hate you.wav" ).play( );    
        }
        
        i++;
        
        graphic = _sprite;
		
		GameWorld.door.unlock();
		
    }
}