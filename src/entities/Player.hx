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

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		sprite = new Spritemap( "gfx/swordguy2.png", 48, 32 );
        
		sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );               
		sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
        
        sprite.scale = scaleFactor;
		
		graphic = sprite;
		
		// defines left, right, up, down as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W]);
        Input.define("down", [Key.DOWN, Key.S]);
		Input.define("change_color", [Key.SPACE]);
		
		
		
		gravity.y = 0.5;
        maxVelocity.y = 12;
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
		
		if ( Input.check("up") && onGround( ) )
		{            
            acceleration.y = -gravity.y * maxVelocity.y;
		}
		
		trace(Input.mouseX + "," + Input.mouseY);
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
    }
	
	public override function update()
    {   
        super.update();
        
		handleInput();
        
        setAnimations( );
		
    }
}