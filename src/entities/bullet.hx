package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image; 

class Bullet extends Entity
{    
	public function new(x:Float, y:Float)    
	{        
		super(x, y);         
		graphic = Image.createRect(1, 6);
        setHitbox(1, 6);
        type = "bullet";
	}
    
	
	public override function update()    
	{   
		moveBy(20, 0, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
			{	      
				world.remove(this);  
			}
	}
}