package com.matttuttle;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.CollisionType;

class PhysicsEntity extends Entity
{
	// Define variables
	public var velocity:Point;//      = new Point( 0, 0 );	//
	public var acceleration:Point;//  = new Point( 0, 0 );	//I had to move this into the
	public var friction:Point;//      = new Point( 0, 0 );	//constructor.
	public var maxVelocity:Point;//   = new Point( 0, 0 );	//
	public var gravity:Point;//       = new Point( 0, 0 );	//
	public var solid:String = CollisionType.STATIC_SOLID;
	
	private var _onGround:Bool;
	private var _onWall:Bool;
    
    public function new(x:Float, y:Float) 
	{
        super( x, y );
        
        _onGround = _onWall = false;
		
		velocity = new Point( 0, 0 );
		acceleration = new Point( 0, 0 );
		friction = new Point( 0, 0 );
		maxVelocity = new Point( 0, 0 );
		gravity = new Point( 0, 0 );
    }
	
	public function onGround( ):Bool { return _onGround; }
	public function onWall( ):Bool { return _onWall; }
	
	override public function update( )
	{
		super.update( );
		
		velocity.x += acceleration.x;
		velocity.y += acceleration.y;
		
		applyVelocity( );
		applyGravity( );
		checkMaxVelocity( );
		applyFriction( );
		
		// Reset acceleration
		acceleration.x = 0;
		acceleration.y = 0;
	}
	
	public function applyGravity( )
	{
		velocity.x += gravity.x;
		velocity.y += gravity.y;
	}
	
	private function checkMaxVelocity( )
	{
		if(maxVelocity.x > 0 && Math.abs( velocity.x ) > maxVelocity.x )
		{
			velocity.x = maxVelocity.x * sign(velocity.x);
		}
		
		if( maxVelocity.y > 0 && Math.abs( velocity.y ) > maxVelocity.y )
		{
			velocity.y = maxVelocity.y * sign(velocity.y);
		}
	}
	
	private function applyFriction( )
	{

		
		// If we're on the ground, apply friction
		if( _onGround )//&& friction.x )  //I need to see what friction.x is set to that makes this true.
		{
			if( velocity.x > 0 )
			{
				velocity.x -= friction.x;
				if( velocity.x < 0 )
				{
					velocity.x = 0;
				}
			}
			else if(velocity.x < 0)
			{
				velocity.x += friction.x;
				if( velocity.x > 0 )
				{
					velocity.x = 0;
				}
			}
		}
		
		// Apply friction if on a wall
		if( _onWall )//&& friction.y )	//I need to see what friction.y is set to that makes this true.
		{
			if( velocity.y > 0 )
			{
				velocity.y -= friction.y;
				
				if( velocity.y < 0 )
				{
					velocity.y = 0;
				}
			}
			else if( velocity.y < 0 )
			{
				velocity.y += friction.y;
				
				if( velocity.y > 0 )
				{
					velocity.y = 0;
				}
			}
		}
	}
	
	private function applyVelocity( )
	{
		_onGround = false;
		_onWall = false;
		
		var i = 0;
		var j = 0;
		
		while( i < Math.abs( velocity.x ) )
		{
			if( collide( solid, x + sign( velocity.x ), y ) != null )
			{
				_onWall = true;
				velocity.x = 0;
				break;
			}
			else
			{
				x += sign(velocity.x);
			}
			
			i++;
		}
		
		while( j < Math.abs( velocity.y ) )
		{
			if( collide( solid, x, y + sign( velocity.y ) ) != null )
			{
				if( sign( velocity.y ) == sign( gravity.y ) )
				{
					_onGround = true;
				}
				
				velocity.y = 0;
				
				break;
			}
			else
			{
				y += sign( velocity.y );
			}
			j++;
		}
	}
	
	//This method comes from com.flashpunk.fp
	//I just put it here for now until we decide if we want to move it
	/**
	 * Finds the sign of the provided value.
	 * @param	value		The Number to evaluate.
	 * @return	1 if value > 0, -1 if value < 0, and 0 when value == 0.
	 */
	public static function sign(value:Float):Int
	{
		return value < 0 ? -1 : (value > 0 ? 1 : 0);
	}
}
