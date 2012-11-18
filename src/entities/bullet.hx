package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image;
//import com.haxepunk.graphics.PreRotation;
import com.matttuttle.PhysicsEntity;
import com.haxepunk.graphics.Spritemap;

class Bullet extends PhysicsEntity
{    
	public static var exists:Bool = false;
	private var orb:Spritemap;
	private var _deltaX:Float;
	private var _deltaY:Float;
	private var _angle:Float;
	
	public function new(x:Float, y:Float, dX:Float, dY:Float, angle:Float)    
	{        
		super(x, y - 5); 
		_deltaX = dX;
		_deltaY = dY;
		_angle = angle;
		orb = new Spritemap("gfx/small_orb.png");
		graphic = orb;
        setHitbox(6, 6);
	}
    
	
	public override function update()    
	{  
		moveBy(_deltaX/10, _deltaY/10, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			world.remove(this); 
			exists = false;
		}
	}
	private function setSpeed()
	{
		
		while (_deltaX > 10 || _deltaY > 10) {
			_deltaX = _deltaX / 2;
			_deltaY = _deltaY / 2;
		}
	}
}