package entities;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;
import com.matttuttle.PhysicsEntity;
import nme.display.BitmapData;

class Player extends PhysicsEntity
{
	private var flip:Bool = false;
    private var sprite:Spritemap;
    private var scaleFactor:Float = .5;
	private var _fuel:Float = 100;
    public var gun:GravityGun;
    private var explosionEmitter:Emitter;
    
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		gun = new GravityGun( 50, 35 );
		
		sprite = new Spritemap( "gfx/swordguy2.png", 48, 32 );
        
		sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );               
		sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
        
        sprite.scale = scaleFactor;
		
		// defines left, right, up, down as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W, Key.SPACE]);
        Input.define("down", [Key.DOWN, Key.S]);
		
		gravity.y = 0.5;
        maxVelocity.y = 1.1;
        maxVelocity.x = 1.5;
        friction.x = 1;
        friction.y = 0;
        
        explosionEmitter = new Emitter(new BitmapData(5, 5), 3, 3);
        
        // Define our particles
        explosionEmitter.newType("explode",[0]);
        explosionEmitter.setAlpha("explode",1,0);
        explosionEmitter.setMotion("explode", 0, 50, 4, 180, -40, -0.5, Ease.quadOut );
        explosionEmitter.setColor("explode", 0xff0000, 0xffff00 );
        explosionEmitter.relative = false;
        
        graphic = new Graphiclist( );
        
        cast( graphic, Graphiclist ).add( sprite );
        cast( graphic, Graphiclist ).add( explosionEmitter );
        
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
			if (_fuel <= 70)
			{
				maxVelocity.y = 2;
			}
			else if (_fuel <= 20)
			{
				maxVelocity.y = 3;
			}
            acceleration.y = -gravity.y * maxVelocity.y;
			_fuel-=4;
			explosionEmitter.emit("explode",x + width/2, y+ height/2);
		}
		
		if ( _fuel < 100 && !Input.check("up"))
		{
			maxVelocity.y = 1.1;
			_fuel++;
		}
		
		if ( onGround( ) )
		{
			maxVelocity.y = 1.1;
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