package worlds;

import com.haxepunk.Entity;
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Text;
import entities.Bubble;

/**
 * ...
 * @author Pumpkin Eaters
 */

class Intro extends World 
{
	
    public function new() 
    {
        super( );
        add( new Bubble(180, 10) );
		
        var titleText:Text = new Text("Press X to Start");
        var textEntity:Entity = new Entity(0,0,titleText);
        textEntity.x = (HXP.width/2)-(titleText.width/2);
        textEntity.y = (HXP.height / 2) - (titleText.height / 2);
        
        add(textEntity);
        
        var splashText:Text = new Text( "Monastery", 100, 10, 640, 480 );
        splashText.color = 0x00ff00;
        splashText.size = 32;
        
        var splashEntity:Entity = new Entity(0,0,splashText);
        splashEntity.x = (HXP.width/2)-(splashText.width/2);
        splashEntity.y = 100;
        
        add(splashEntity);
    }
    
    override public function update() 
    {
        if (Input.check(Key.X)) 
        {
            HXP.screen.color = 0x222233;
            HXP.world=new GameWorld( "maps/map_level1.tmx", "maps/map_level2.tmx" );
        }
    }
}