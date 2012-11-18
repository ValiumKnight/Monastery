package entities;

import com.haxepunk.graphics.Spritemap;
import com.matttuttle.PhysicsEntity;

/**
 * ...
 * @author Pumpkin Eater
 */

class Plant extends PhysicsEntity
{
    private var _plant_sprite: Spritemap;
	private var _pointX: Float;
	private var _pointY: Float;
	private var scaleFactor:Float = 0.25;

	public function new(x:Float, y:Float, image:String) 
	{
		super(x, y);
		
		_plant_sprite = new Spritemap("gfx/" + image, 70, 72);
        
        _plant_sprite.add( "stand", [ 0, 1, 2, 3, 4, 5,
                                      6, 7, 8, 9, 10, 11,
                                      12, 13, 14, 15], 20, true );
		_plant_sprite.scale = scaleFactor;
        
		graphic = _plant_sprite;
		
		layer = 0;
		
		gravity.y = 0.5;
        maxVelocity.y = 1.1;
        maxVelocity.x = 1.5;
        friction.x = 1;
        friction.y = 0;
		
		type = CollisionType.PLANT;
		
		setHitbox( Std.int( 70 * scaleFactor ), Std.int( 72 * scaleFactor ) );
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
		
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
        var furnace:Furnace = cast( collide( CollisionType.FURNACE , x , y ), Furnace );
        
		if ( furnace != null )
		{	
			var player:Player = cast(collide( CollisionType.PLAYER , x , y ), Player);
			
			if (player != null ) {
				player._equiped = false;
			}
            
            furnace.burnPlant( );
            
			destroy();
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
        
        _plant_sprite.play( "stand" );
        
		handleInput();
        
        setAnimations( );
		
    }
	public function destroy()
	{
		world.remove(this);
	}
	
}