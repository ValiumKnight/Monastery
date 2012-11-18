package worlds;

import com.haxepunk.Entity;
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Text;
import entities.Bubble;
import entities.GravityPoint;

/**
 * ...
 * @author Pumpkin Eaters
 */

class Credits extends World 
{
	
    public function new() 
    {
        super( );
		
        var titleText:Text = new Text("Thank You For Playing! \nPress Y to Start Again!");
        var textEntity:Entity = new Entity(0,0,titleText);
        textEntity.x = (HXP.width/2)-(titleText.width/2);
        textEntity.y = (HXP.height / 2) - (titleText.height / 2);
        
        add(textEntity);
        
        var splashText:Text = new Text( "Monastery", 100, 5, 640, 480 );
        splashText.color = 0x00ff00;
        splashText.size = 32;
        
        var splashEntity:Entity = new Entity(0,0,splashText);
        splashEntity.x = (HXP.width/2)-(splashText.width/2);
        splashEntity.y = 100;
        
        add(splashEntity);
		
		
		var creditText:Text = new Text("Andrea Della Corte \nRob Filippi \nMike Minella \n(Team Pumpkin Eaters)");
        var creditEntity:Entity = new Entity(220, 220,creditText);
        
        add(creditEntity);
		
		
    }
    
    override public function update() 
    {
        if (Input.check(Key.Y)) 
        {
            HXP.screen.color = 0x222233;
            HXP.world=new Intro( );
        }
    }
}