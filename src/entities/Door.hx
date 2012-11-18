package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import worlds.Credits;
import worlds.GameWorld;
import worlds.Intro;
import worlds.Credits;

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
		if ( unlocked && cast(collide( CollisionType.PLAYER , x , y ) != null ) )
		{
			unlocked = false;
			if (Intro.cur_lvl == 2)
			{
				Intro.cur_lvl = 0;
				HXP.world = new Credits();
			}
			else
			{
				Intro.cur_lvl++;
				HXP.world = new GameWorld( Intro.level[Intro.cur_lvl] );
			}
            
		}
	}
	
	public function unlock()
	{
		_sprite = new Image("gfx/door_open.png");
		
		graphic = _sprite;
		
		unlocked = true;
	}
}