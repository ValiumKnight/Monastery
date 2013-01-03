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

class Bubble extends Entity
{
    private var _sprite: Image;

	public function new(x:Int, y:Int, text:String ) 
	{
		super(x, y);
        
        _sprite = new Image("graphics/small_orb.png");
		
		graphic = _sprite;
	}
	
	public override function update()    
	{ 
		
	}
}