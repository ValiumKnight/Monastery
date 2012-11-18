package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import worlds.GameWorld;
import com.haxepunk.HXP;

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
			player.x = 100;
			player.y = 50;
			player._equiped = false;
            
            var gameWorld:GameWorld = cast( world, GameWorld );
            
            HXP.world = new GameWorld( gameWorld._world );
		}   
	}
}