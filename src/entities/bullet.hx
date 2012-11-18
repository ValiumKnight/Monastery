package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image;
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
		super(x, y); 
		_deltaX = dX;
		_deltaY = dY;
		_angle = angle;
        
        var sprite:Spritemap = new Spritemap("gfx/sprite_orb2.png", 21, 21);
        
        sprite.scale = 0.5;
        
		orb = sprite;
		orb.add( "shoot", [0, 1, 2, 3], 10, true );
		graphic = orb;
        setHitbox(6, 6);
		exists = true;
        
        type = CollisionType.BULLET;
	}
    
	private function setAnimations()
    {
		orb.play("shoot");
    }
	
	public override function update()    
	{  
		moveBy(_deltaX / 10, _deltaY / 10, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			world.remove(this); 
			exists = false;
		}
        
        var gp:GravityPoint = cast( collide( CollisionType.GRAVITY_POINT, x, y ), GravityPoint );
        
        if ( gp != null )
        {
            gp.enabled = !gp.enabled;
            world.remove(this);
            exists = false;
        }
        
		setAnimations();
	}
	private function setSpeed()
	{
		
		while (_deltaX > 10 || _deltaY > 10) {
			_deltaX = _deltaX / 2;
			_deltaY = _deltaY / 2;
		}
	}
}