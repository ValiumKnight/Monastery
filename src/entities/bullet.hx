package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image; 

class Bullet extends Entity
{    
	public static var exists:Bool = false;
	
	public function new(x:Float, y:Float)    
	{        
		super(x, y);         
		graphic = Image.createCircle(6, 660066 );
        setHitbox(6, 6);
        type = "bullet";
		exists = true;
	}
    
	
	public override function update()    
	{   
		moveBy(7, 0, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			world.remove(this); 
			exists = false;
		}
	}
}