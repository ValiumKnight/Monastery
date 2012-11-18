package entities;

import com.haxepunk.graphics.PreRotation;
import worlds.GameWorld;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;
/**
 * ...
 * @author Pumpkin Eater
 */

class GravityGun extends Entity
{
  //  private var _sprite: PreRotation;
	private var _bullet: Bullet;
	private var _pointX: Float;
	private var _pointY: Float;
	private var _shoot: Bool = false;
	public static var exists:Bool = false;
	private var scaleFactor:Float = 0.5;
    private var flipped:Bool = false;
    
    private var gravityOnSfxs:Array<Sfx>;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
        
        gravityOnSfxs = new Array<Sfx>( );
        
        gravityOnSfxs.push( new Sfx( "sfx/shoot1.wav" ) );
        
        layer = 0;
		
		exists = true;

	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
		_pointX = Input.mouseX - x;
		_pointY = Input.mouseY - y;
		
		if (Input.mousePressed && !Bullet.exists)
		{    
			_shoot = true;
		}
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
		var frameAngle = -(Math.atan2(_pointY, _pointX) * (180 / Math.PI));
		
		if (_shoot)
		{
            gravityOnSfxs[Std.int( 0* gravityOnSfxs.length )].play( );
			_bullet = new Bullet(x + width, y + height / 4, _pointX, _pointY, frameAngle);
			world.add(_bullet);
			_shoot = false;
		}
    }
	
	public function setCords(newX, newY)
    {   
		x = newX + 10.0;
		y = newY;
    }	
	
	public override function update()
    {   
        super.update();
        
		handleInput();
        
        setAnimations( );
		
    }
	public function destroy() {
			
		if (exists)
		{
			world.remove(this);
			exists = false;
		}
	}
	

}