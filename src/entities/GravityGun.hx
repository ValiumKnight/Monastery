package entities;

import com.haxepunk.graphics.PreRotation;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
/**
 * ...
 * @author Pumpkin Eater
 */

class GravityGun extends Entity
{
    private var _sprite: PreRotation;
	private var _pointX: Float;
	private var _pointY: Float;
	private var _shoot: Bool = false;
	private var scaleFactor:Float = 0.5;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		_sprite = new PreRotation("gfx/space_gun.png");
		_sprite.scale = scaleFactor;
        
		graphic = _sprite;
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
		//trace(Input.mouseX + "," + Input.mouseY);
		
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
		_sprite.frameAngle =  frameAngle;
		
		if (_shoot)
		{
			world.add(new Bullet(x + width, y + height / 4, _pointX, _pointY, frameAngle));
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
	

}