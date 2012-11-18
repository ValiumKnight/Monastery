package worlds;

import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import entities.Block;
import entities.Player;
import entities.CollisionType;

class GameWorld extends World
{
	public function new() 
	{
		super ();
	}
	
	public override function begin()
	{
		
		add( new Player( 50, 50 ) );
        
        createMap( );
	}
	
    public function createMap( )
    {
      // create the map, set the assets in your nmml file to bytes
      var e = new TmxEntity("maps/map01.tmx");

      // load layers named bottom, main, top with the appropriate tileset
      e.loadGraphic("gfx/tiles.png", ["main"]);

      // loads a grid layer named collision and sets the entity type to walls
      e.loadMask( "main", CollisionType.STATIC_SOLID );
      
      var objectGroup:TmxObjectGroup = e.map.getObjectGroup( "objects" );
      
      if ( objectGroup != null )
      {
        for ( object in objectGroup.objects )
        {
            if ( object.type == "crate" )
            {
                add( new Block( object.x, object.y ) );
            }
        }
      }

      add(e);
    }
}