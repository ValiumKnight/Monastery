package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import worlds.GameWorld;

/**
 * ...
 * @author Pumpkin Eaters
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
		var plant:Plant = cast(collide( CollisionType.PLANT , x , y ), Plant);
		
		if ( player != null )
		{
			player._equiped = false;
            
            var gameWorld:GameWorld = cast( world, GameWorld );
            
            HXP.world = new GameWorld( gameWorld._world, gameWorld._nextWorld );
		}
	}
}