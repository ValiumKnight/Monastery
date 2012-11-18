package entities;

import com.haxepunk.graphics.PreRotation;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.matttuttle.PhysicsEntity;
import com.matttuttle.PhysicsEntity;
/**
 * ...
 * @author Pumpkin Eater
 */

class GravityGun extends Entity
{
    private var _sprite: PreRotation;
	private var _pointX: Float;
	private var _pointY: Float;
	private var scaleFactor:Float = 0.5;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		//_pointX = x;
		//_pointY = y;
		
		_sprite = new PreRotation("gfx/space_gun.png");
		_sprite.scale = scaleFactor;
		graphic = _sprite;
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
		
		trace(Input.mouseX + "," + Input.mouseY);
		
		_pointX = Input.mouseX - x;
		_pointY = Input.mouseY - y;
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
		
		_sprite.frameAngle =  -(Math.atan2(_pointY, _pointX) * (180 / Math.PI));
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