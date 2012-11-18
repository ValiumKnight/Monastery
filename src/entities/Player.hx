package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.matttuttle.PhysicsEntity;

class Player extends PhysicsEntity
{
	private var flip:Bool = false;
    private var sprite:Spritemap;
    private var scaleFactor:Float = 0.5;
	private var _fuel:Float = 100;
    public var gun:GravityGun;
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		gun = new GravityGun( 50, 35 );
		
		sprite = new Spritemap( "gfx/swordguy2.png", 48, 32 );
        
		sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );               
		sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
        
        sprite.scale = scaleFactor;
		
		graphic = sprite;
		
		// defines left, right, up, down as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W, Key.SPACE]);
        Input.define("down", [Key.DOWN, Key.S]);
		
		gravity.y = 0.1;
        maxVelocity.y = 1.5;
        maxVelocity.x = 1.5;
        friction.x = 1;
        friction.y = 0;
        
        type = CollisionType.PLAYER;

        
        setHitbox( Std.int( sprite.width * scaleFactor ), Std.int( sprite.height * scaleFactor ) );
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
        if ( Input.check("left") )
        {
			flip = true;
            acceleration.x = -maxVelocity.x;
        }
 
        if ( Input.check("right") )
        {
			flip = false;
            acceleration.x = maxVelocity.x;
        }        

		if ( Input.check("up") && _fuel > 0 )
		{   
            acceleration.y = -gravity.y * maxVelocity.y;
			_fuel-=2;
			
		}
		
		if ( _fuel < 100 && !Input.check("up"))
		{
			_fuel++;
		}
		
		if ( onGround( ) )
		{
			_fuel = 100;
		}
		
		trace ("FUEL =" + _fuel + "%");
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
        // Value > 3, keeps sprite standing still
        if ( Math.abs( velocity.x ) < 0.3 && onGround( ) )
        {
            sprite.play("stand");

        }
        else
        {
            sprite.play("run");
        }
        
        sprite.flipped = flip;
		gun.setCords(x, y);		
    }
	
	public override function update()
    {   
        super.update();
        
		handleInput();
        
        setAnimations( );
    }
}