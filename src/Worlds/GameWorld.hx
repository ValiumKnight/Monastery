package worlds;

import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import entities.Block;
import entities.GravityGun;
import entities.GravityPoint;
import entities.Plant;
import entities.Player;
import entities.CollisionType;
import com.matttuttle.PhysicsEntity;
import entities.Spikes;

class GameWorld extends World
{
    private var player:Player;
    private var plant:Plant;
    public var dynamic_entities:Array<PhysicsEntity>;
    public var gravity_points:Array<GravityPoint>;    
    
	public function new() 
	{
		super ( );
        
        dynamic_entities = new Array<PhysicsEntity>( );
        gravity_points = new Array<GravityPoint>( );
        
        player = new Player( 100, 50 );
		plant = new Plant (65, 80, "space_gun.png");
		
		add(player);
        add(player.gun);
        add(player.fuelBar);
		add(plant);
		
        player.layer = 1;
        player.gun.layer = 1;
        
        dynamic_entities.push( player );
        //dynamic_entities.push( plant );
		
        createMap( );
	}
	
    public function createMap( )
    {
        // create the map, set the assets in your nmml file to bytes
        var e = new TmxEntity("maps/map_level1.tmx");

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
				
				if ( object.type == "furnace" )
                {
                    add( new Block( object.x, object.y ) );
                }				
				
				if ( object.type == "spikes" )
                {
                    add( new Spikes( object.x, object.y ) );
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
            //add( gravity_point.circle );
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
                if ( !gravity_point.enabled )
                {
                    entity.gravity.y = 0.5;
                    continue;
                }
                
                if ( entity.type == CollisionType.PLAYER )
                {
                    if (entity.collide( CollisionType.GRAVITY_POINT, entity.x, entity.y ) != null )
                    {
                        continue;
                    }
                }
                
                var planetDistance_x:Float = entity.x - gravity_point.x;
                var planetDistance_y:Float = entity.y - gravity_point.y;
                
                var finalDistance:Float = Math.sqrt( Math.pow( planetDistance_x, 2 ) + Math.pow( planetDistance_y, 2 ) );
                
                if( finalDistance <= gravity_point.radius * 3 )
                {
                    entity.gravity.y = 0;
                        
                    var strength:Float = Math.abs(planetDistance_x) + Math.abs(planetDistance_y);
                    var force_x:Float = planetDistance_x *( (1 / strength) * gravity_point.radius / finalDistance) * 1;
                    var force_y:Float = planetDistance_y *( (1 / strength) * gravity_point.radius / finalDistance) * 1;
                    entity.acceleration.x -= force_x;
                    entity.acceleration.y -= force_y;
                }
                else
                {
                    entity.gravity.y = 0.5;
                }
            }
        }
    }
}