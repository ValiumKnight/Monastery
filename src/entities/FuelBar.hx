package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;

class FuelBar extends Entity
{   
    private var healthbar:Spritemap;
    private var health:Int = 16;
    private var dead:Bool = false;
    
    public function new()
    {
        super( );
        
        healthbar = new Spritemap("gfx/circlehealthbar.png", 32, 32);
        graphic = healthbar;
        healthbar.centerOO();
        healthbar.frame = 16;
    }
    
    private function adjustBar()
    {
        
        healthbar.frame = health ;
    }
    
    public function getHealth():Int
    {
        return health;
    }
    
    public function setHealth(value:Int)
    {
        health = value;
        
        adjustBar();
    }
}