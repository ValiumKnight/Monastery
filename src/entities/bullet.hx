package entities; 

import com.haxepunk.Entity; 
import com.haxepunk.graphics.Image;
import com.matttuttle.PhysicsEntity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import worlds.GameWorld;

class Bullet extends PhysicsEntity
{    
	public static var exists:Bool = false;
	public static var GP:GravityPoint;
	private var orb:Spritemap;
	private var _deltaX:Float;
	private var _deltaY:Float;
	private var _angle:Float;
	private var _destroy: Bool = false;
	
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
        setHitbox(8, 8);
		exists = true;
        
        type = CollisionType.BULLET;
		
		Input.define("destroy", [Key.Q]);
	}
	
	private function handleInput()
    {
		if ( Input.check("destroy") ) 
		{
			_destroy = true;
		}
	}
	
	private function setAnimations()
    {
		orb.play("shoot");
		
		if (_destroy)
		{
			destroyBullet();
		}
    }
	
	public override function update()    
	{
        setSpeed( );
        
		moveBy(_deltaX / 10, _deltaY / 10, "enemy");
		super.update();
			
		if ( collide( CollisionType.STATIC_SOLID , x , y ) != null )
		{	      
			destroyBullet();
		}
        
        var gp:GravityPoint = cast( collide( CollisionType.GRAVITY_POINT, x, y ), GravityPoint );
        
        if ( gp != null && gp != GameWorld.button_gp )
        {
			if (GP != null && GP.enabled && GP != gp)
			{
				GP.toggle( );
			}
			gp.toggle();
			GP = gp;
			destroyBullet();
        }
        
		setAnimations();
		handleInput();
	}
    
	private function setSpeed()
	{
		while (_deltaX > 45 || _deltaY > 45 ) {
			_deltaX = _deltaX / 2;
			_deltaY = _deltaY / 2;
		}
	}
	public function destroyBullet() {
			
			if (exists)
			{
				world.remove(this);
				exists = false;
			}
	}
}