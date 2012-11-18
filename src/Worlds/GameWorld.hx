package worlds;

import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import entities.Block;
import entities.GravityGun;
import entities.GravityPoint;
import entities.Player;
import entities.CollisionType;
import com.matttuttle.PhysicsEntity;

class GameWorld extends World
{
    public var dynamic_entities:Array<PhysicsEntity>;
    public var gravity_points:Array<GravityPoint>;    
    
	public function new() 
	{
		super ();
        
        dynamic_entities = new Array<PhysicsEntity>( );
        gravity_points = new Array<GravityPoint>( );
        
        add( new Player( 50, 50 ) );
        
		add( new GravityGun( 50, 35 ) );
        
        //dynamic_entities.push( player );
		
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
                
                if ( object.type == "gravitypoint" )
                {
                    gravity_points.push( new GravityPoint( object.x, object.y ) );
                }
            }
        }
      
        for ( gravity_point in gravity_points )
        {
            add( gravity_point );      
        }

      add(e);
    }
    
    public override function update( )
    {
        super.update( );
        
        for ( entity in dynamic_entities ) 
        {            
            for ( gravity_point in gravity_points )
            {
                var planetDistance_x:Float = entity.x - gravity_point.x;
                var planetDistance_y:Float = entity.y - gravity_point.y;
                
                var finalDistance:Float = Math.sqrt( Math.pow( planetDistance_x, 2 ) + Math.pow( planetDistance_y, 2 ) );
                
                if( finalDistance <= gravity_point.radius * 3)
                {
                    var strength:Float=Math.abs(planetDistance_x)+Math.abs(planetDistance_y);
                    var force_x:Float = planetDistance_x *( (1 / strength) * gravity_point.radius / finalDistance);
                    var force_y:Float = planetDistance_y *( (1 / strength) * gravity_point.radius / finalDistance);
                    entity.acceleration.x -= force_x;
                    entity.acceleration.y -= force_y;
                }
            }
        }
    }
}