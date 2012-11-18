package worlds;

import com.haxepunk.Entity;
import com.haxepunk.Sfx;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import entities.Furnace;
import entities.Door;
import entities.GravityGun;
import entities.GravityPoint;
import entities.Plant;
import entities.Player;
import entities.CollisionType;
import com.matttuttle.PhysicsEntity;
import entities.Spikes;

class GameWorld extends World
{
    public var player:Player;
    private var plant:Plant;
    public var dynamic_entities:Array<PhysicsEntity>;
    public var gravity_points:Array<GravityPoint>;
    public var _world:String;
    public var _nextWorld:String;
    public static var door:Door;
	
	public function new(world:String, nextWorld:String) 
	{
		super ( );
        
        _world = world;
        
        _nextWorld = nextWorld;
        
        var background:Entity = new Entity( );
        
        background.graphic = new Image( "gfx/space_window.png" );
        
        add( background );
        
        dynamic_entities = new Array<PhysicsEntity>( );
        gravity_points = new Array<GravityPoint>( );
		
        createMap( );
	}
	
    public function createMap( )
    {
        // create the map, set the assets in your nmml file to bytes
        var e = new TmxEntity(_world);

        // load layers named bottom, main, top with the appropriate tileset
        e.loadGraphic("gfx/tiles.png", ["main"]);

        // loads a grid layer named collision and sets the entity type to walls
        e.loadMask( "main", CollisionType.STATIC_SOLID );

        var objectGroup:TmxObjectGroup = e.map.getObjectGroup( "objects" );
		
      
        if ( objectGroup != null )
        {
            for ( object in objectGroup.objects )
            {
				if ( object.type == "plant" )
                {
                    var plant:Plant = new Plant( object.x, object.y, "plant.png", true);
                    
                    dynamic_entities.push( plant );
                    add( plant );
                }
                
                if ( object.type == "player" )
                {
                    player = new Player( object.x, object.y );
                    
                    dynamic_entities.push( player );
                    add(player);
                    add(player.gun);
                    add(player.fuelBar);
                }
				
                if ( object.type == "furnace")
                {
                    add( new Furnace( object.x, object.y ) );
                }				
				
				if ( object.type == "spikes" )
                {
                    add( new Spikes( object.x, object.y ) );
                }
                    
                if ( object.type == "gravitypoint" )
                {
                    gravity_points.push( new GravityPoint( object.x, object.y ) );
                }                
				
				if ( object.type == "door" )
                {
                    add( door = new Door( object.x, object.y ) );
                }
            }
        }
      
        for ( gravity_point in gravity_points )
        {
            add( gravity_point );
        }

        add( e );
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
				
				if ( entity.type == CollisionType.PLANT )
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