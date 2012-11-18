package entities;
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

/**
 * ...
 * @author Pumpkin Eater
 */

class Plant extends Entity
{
    private var _plant_sprite: Image;
	private var _pointX: Float;
	private var _pointY: Float;
	private var _shoot: Bool = false;
	private var scaleFactor:Float = 0.5;

	public function new(x:Float, y:Float, image:String) 
	{
		super(x, y);
		
		_plant_sprite = new Image("gfx/"+image);
		_plant_sprite.scale = scaleFactor;
        
		graphic = _plant_sprite;
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
		
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
		
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