package ;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.nape.FlxPhysSprite;
import org.flixel.nape.FlxPhysState;

/**
 * ...
 * @author Mike Cugley
 */
class PlayState extends FlxPhysState
{
	var bombs: FlxGroup;  // Bombs - explode on click, and also if hit by an explosion.  Clear these to win the level.
	var rocks: FlxGroup;  // Rocks.  Don't explode.  Don't need to clear these to win the level
	var hud: FlxGroup; // Group for the HuD.
	

	public function new() 
	{
		super();
	}
	
	override public function create():Void
	{
		super.create();

		
		// FlxPhysState shortcut to create bondaries around game area. 
		createWalls(Registry.worldMinX, Registry.worldMinY, Registry.worldMaxX, Registry.worldMaxY);
		
		FlxPhysState.space.gravity.setxy(0,0);  // No Gravity		
		
		// define the extents of space
		FlxG.camera.setBounds(Registry.worldMinX, Registry.worldMinY, Registry.worldMaxX, Registry.worldMaxY, true);
		
		// Create a bunch of bombs
		
		// Possibly create some rocks
		var foo:FlxPhysSprite = new FlxPhysSprite(100, 100);
		add(foo);
		
	}
	
	override public function update()
	{
		super.update();
	}
	
}