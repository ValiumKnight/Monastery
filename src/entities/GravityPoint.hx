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
    
    public var radius:Int;
    
    public var circle:Entity;
    
    public var enabled:Bool;

	public function new(x:Int, y:Int) 
	{
		super(x, y);
        
        radius = 20;
        
        _sprite = new Spritemap("gfx/block.png");
        
        _sprite.scale = 0.5;
        
        circle = new Entity( x - radius*3 + _sprite.width / 4, y - radius*3 + _sprite.height / 4 );
        
        var circle_image:Image = Image.createCircle(radius*3, 660066);
        
        circle_image.alpha = 0.4;
        
        circle.graphic = circle_image;
        
        type = CollisionType.GRAVITY_POINT;
        
        setHitbox( Std.int( _sprite.width * _sprite.scale ), Std.int( _sprite.height * _sprite.scale ) );
		
		graphic = _sprite;
	}
	
	public override function update()
    {
        super.update();
    }
}