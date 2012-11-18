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
		super(x, y - 11); 
		orb = new Spritemap("gfx/sprite_orb2.png", 21, 21);
		orb.add( "shoot", [0, 1, 2, 3], 10, true );
		
		graphic = orb;
        type = "bullet";
		exists = true;
	}
    
	private function setAnimations()
    {
		orb.play("shoot");
    }
	
	public override function update()    
	{   
		moveBy(1, 0, "enemy");
		setAnimations();
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			world.remove(this); 
			exists = false;
		}
	}
}