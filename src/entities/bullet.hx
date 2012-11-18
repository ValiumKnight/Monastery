package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;

class Bullet extends Entity
{    
	public static var exists:Bool = false;
	private var orb:Spritemap;
	
	public function new(x:Float, y:Float)    
	{   
		super(x, y - 5); 
		orb = new Spritemap("gfx/small_orb.png");
		graphic = orb;
        type = "bullet";
		exists = true;
	}
    
	
	public override function update()    
	{   
		moveBy(2, 0, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			world.remove(this); 
			exists = false;
		}
	}
}