package entities;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;
import com.matttuttle.PhysicsEntity;
import nme.display.BitmapData;

class Player extends PhysicsEntity
{
	public var flip:Bool = false;
	private var _equip:Bool = false;
	public var _equiped:Bool = false;
    private var sprite:Spritemap;
    private var scaleFactor:Float = .5;
	private var _actualFuel:Float = 16;
    private var _maxFuel:Int = 16;
    private var _takenBefore:Bool = false;
    private var explosionEmitter:Emitter;
    private var jetpackSfx:Sfx;
    public var fuelBar:FuelBar;
    public var gun:GravityGun;
    
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		gun = new GravityGun( 50, 35 );
        
        fuelBar = new FuelBar( HXP.screen.width - 50, 80 );
        
        fuelBar.layer = 1;
        
        layer = 5;
        
        jetpackSfx = new Sfx( "music/jetpack.wav" );
	
		sprite = new Spritemap( "gfx/chef.png", 48, 48 );

        
		sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );               
		sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
        
        sprite.scale = scaleFactor;
		
		// defines left, right, up, down as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W, Key.SPACE]);
        Input.define("down", [Key.DOWN, Key.S]);
		Input.define("equip", [Key.E]);
		
		gravity.y = 0.5;
        maxVelocity.y = 1.1;
        maxVelocity.x = 1.5;
        friction.x = 1;
        friction.y = 0;
        
        explosionEmitter = new Emitter(new BitmapData(5, 5), 3, 3);
        
        // Define our particles
        explosionEmitter.newType("explode",[0]);
        explosionEmitter.setAlpha("explode",1,0);
        explosionEmitter.setMotion("explode", 0, 50, 1, 180, -40, -0.5, Ease.quadOut );
        explosionEmitter.setColor("explode", 0xff0000, 0xffff00 );
        explosionEmitter.relative = false;
        
        graphic = new Graphiclist( );
        
        cast( graphic, Graphiclist ).add( sprite );
        cast( graphic, Graphiclist ).add( explosionEmitter );
        
        type = CollisionType.PLAYER;
        
        setHitbox( Std.int( 48 * scaleFactor ), Std.int( 48 * scaleFactor ) );
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

		if ( Input.check("up") && _actualFuel > 0 )
		{   
            //if ( !jetpackSfx.playing )
            {
                jetpackSfx.play( );
            }
            
			if (_actualFuel <= 70)
			{
				maxVelocity.y = 3;
			}
			else if (_actualFuel <= 20)
			{
				maxVelocity.y = 4;
			}
            acceleration.y = -gravity.y * maxVelocity.y;
			_actualFuel-=1;
			explosionEmitter.emit("explode",x + width/2, y+ height/2);
		}
		
		if ( Input.pressed("equip") )
		{
			_equip = !_equip;
		}
		else
		{
			_equip = false;
		}
		
		if ( _actualFuel < _maxFuel && !Input.check("up"))
		{
			maxVelocity.y = 1.1;
			_actualFuel += 0.3;
		}
		
		if ( onGround( ) )
		{
			maxVelocity.y = 1.1;
			_actualFuel = _maxFuel;
		}
        
        fuelBar.setHealth( Std.int( _actualFuel ) );
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
		var plant:Plant = cast(collide( CollisionType.PLANT , x , y ), Plant);
        if ( Math.abs( velocity.x ) < 0.3 && onGround( ) )
        {
            sprite.play("stand");
        }
        else
        {
            sprite.play("run");
        }
		
		if (_equip)
		{
			
			if (_equiped)
			{
				_equiped = false;
			}
			else if ( plant != null )
			{
                if ( !_takenBefore )
                {
                    _takenBefore = true;
                    new Sfx( "music/hello-friend.mp3" ).play( );
                }
				_equiped = true;
			}
		}
		
		if (_equiped && plant != null) 
		{
			gun.destroy();
			plant.setCords(x, y);
		}
		else if (!_equiped && !GravityGun.exists) 
		{
			gun = new GravityGun(x, y);
			gun.layer = 1;
			world.add(gun);
		}
        
        sprite.flipped = flip;
        
		if ( gun != null )
		{
			gun.setCords(x, y);		
		}
	}
	
	public override function update()
    {   
        super.update();
        
		handleInput();
        
        setAnimations( );
    }
}