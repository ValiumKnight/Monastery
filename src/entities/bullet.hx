package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image;
//import com.haxepunk.graphics.PreRotation;
import com.matttuttle.PhysicsEntity;

class Bullet extends PhysicsEntity
{    
	public static var exists:Bool = false;
	private var _sprite:Image;
	private var _deltaX:Float;
	private var _deltaY:Float;
	private var _angle:Float;
	
	public function new(x:Float, y:Float, dX:Float, dY:Float, angle:Float)    
	{        
		super(x, y);
		_deltaX = dX;
		_deltaY = dY;
		_angle = angle;
		_sprite = Image.createCircle(6, 660066 );
		graphic = _sprite;
        setHitbox(6, 6);
        type = "bullet";
		exists = true;

		//setSpeed();
		
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