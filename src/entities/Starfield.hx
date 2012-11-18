package entities;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

/**
 * implements a simple starfield
 * @author Richard Marks
 */
class Starfield extends Graphic
{
    // stars is [star1, star2, star3, etc]
    // star# is [graphic, x, y, color, speed]
    private var stars:Array<Int>;
    
    // number of stars
    private var fieldDensity:Int;
    private var fieldColors:Array<Int>;
    
    public function new( )
    {
        stars = new Array<Int>( );
    }
    
    override public function update() 
    {
        // move stars from the bottom of the screen to the top
        for( star in stars )
        {
            // add speed to the star
            star[2] -= star[4];
            
            if (star[2] < 0)
            {
                // new random x position and warp back to bottom
                star[1] = Math.random() * FP.width;
                star[2] = FP.height;
            }
        }
    }
    
    override public function render(point:Point, camera:Point) 
    {
        for( star in stars )
        {
            cast(star[0], Image).render(new Point(star[1], star[2]), camera);
        }
    }
    
    /**
     * creates a new starfield
     * @param	density - number of stars
     * @param	colors - an array of unsigned integers for each star color depth
     */
    public function Starfield(density:Int = 400, colors:Array<Int> = null) 
    {
        if (colors == null)
        {
            colors = [0x444444, 0x999999, 0xBBBBBB, 0xFFFFFF];
        }
        
        if (density > 1000)
        {
            density = 1000;
        }
        
        fieldDensity = density; 
        fieldColors = colors;
        active = true;
        visible = true;
        
        CreateField();
    }
    
    // creates the starfield
    private function CreateField()
    {
        // new array of stars
        stars = new Array( );
        
        for ( i in 0..fieldDensity )
        {
            // star is [graphic, x, y, color, speed]
            var star:Array = [null, null, null, null, null];
            
            // random position
            star[1] = Math.random() * HXP.width;
            star[2] = Math.random() * HXP.height;
            
            // random speed based on number of available colors
            star[4] = Math.floor(Math.random() * fieldColors.length);
            
            // color based on speed
            star[3] = fieldColors[star[4]];
            
            // star graphic itself
            star[0] = Image.createRect(1, 1, star[3]);
            
            // add star to the stars array
            stars.push(star);
        }
    }	
}