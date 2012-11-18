package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import worlds.GameWorld;

/**
 * ...
 * @author Rob Filippi
 */

class Door extends Entity
{
    private var _sprite: Image;
	public static var unlocked: Bool = false;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        _sprite = new Image("gfx/door.png");
		
		graphic = _sprite;
        
        setHitbox( _sprite.width, _sprite.height );
	}
	
	public override function update()    
	{ 
		var player:Player = cast(collide( CollisionType.PLAYER , x , y ), Player);
		
		if ( player != null  && unlocked)
		{
			var gameWorld:GameWorld = cast( world, GameWorld );
            gameWorld._world = gameWorld._nextWorld;
			gameWorld._nextWorld = "maps/map_level2.tmx" ;
            HXP.world = new GameWorld( gameWorld._world, gameWorld._nextWorld );
		}
	}
	
	public function unlock()
	{
		_sprite = new Image("gfx/door_open.png");
		
		graphic = _sprite;
		
		unlocked = true;
	}
}