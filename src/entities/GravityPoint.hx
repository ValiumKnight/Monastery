package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;

/**
 * ...
 * @author ValiumKnight
 */

class GravityPoint extends Entity
{
    private var _sprite: Spritemap;
    
    public var radius:Float;
    
    public var circle:Entity;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        radius = 40;
        
        circle = new Entity( x, y );
        
        var circle_image:Image = Image.createCircle(40, 660066);
        
        circle_image.alpha = 0.8;
        
        circle.graphic = circle_image;
        
        _sprite = new Spritemap("gfx/block.png");
        
        _sprite.scale = 0.5;
        
        type = CollisionType.STATIC_SOLID;
        
        setHitbox( Std.int( _sprite.width * _sprite.scale ), Std.int( _sprite.height * _sprite.scale ) );
		
		graphic = _sprite;
	}
	
	public override function update()
    {
        super.update();
    }
    
    public function enable( )
    {
        world.add( circle );
    }
}