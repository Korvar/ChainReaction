package ;

import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.phys.Body;
import nape.phys.Material;
import org.flixel.FlxEmitter;
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
		
		// define the extents of space
		FlxG.camera.setBounds(Registry.worldMinX, Registry.worldMinY, (Registry.worldMaxX - Registry.worldMinX), (Registry.worldMaxY - Registry.worldMinY), true);
		
		super.create();
		
		disablePhysDebug();

		bombs = new FlxGroup();
		rocks = new FlxGroup();
		hud = new FlxGroup();
		
		// CB Types
		Registry.CB_Bomb = new CbType();
		Registry.CB_Shrapnel = new CbType();
		Registry.CB_Exploding = new CbType();
		
		// Materials
		Registry.wallmaterial = new Material(1, 0, 0, 1, 0);
		Registry.bombMaterial = new Material(1, 0, 0, 1, 0);
		Registry.shrapnelMaterial = new Material(1, 0, 0, 100, 0);
		Registry.bombMaterial = new Material(1, 0, 0, 1, 0);
		
		
		var shrapnelListener:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, 
			Registry.CB_Bomb, Registry.CB_Shrapnel, shrapnelHitsBomb);
		FlxPhysState.space.listeners.add(shrapnelListener);
		
		
		// FlxPhysState shortcut to create bondaries around game area. 
		createWalls(Registry.worldMinX, Registry.worldMinY, Registry.worldMaxX, Registry.worldMaxY, 10, Registry.wallmaterial);
		
		FlxPhysState.space.gravity.setxy(0,0);  // No Gravity		
		

		
		// Create a bunch of bombs
		for (i in 0...30)
		{
			var bombX:Float = 20 + (FlxG.random() * (Registry.worldMaxX - Registry.worldMinX - 40));
			var bombY:Float = 20 + (FlxG.random() * (Registry.worldMaxY - Registry.worldMinY - 40));
			var newBomb:Bomb = new Bomb(bombX, bombY, 0);
			bombs.add(newBomb);
		}
		add(bombs);
		
		// Possibly create some rocks

		
	}
	
	override public function update()
	{
		super.update();
		
		if (FlxG.mouse.justPressed())
		{
			var newExplosion:Explosion = new Explosion(FlxG.mouse.x, FlxG.mouse.y, 500, 150);
			add(newExplosion);
			newExplosion.explode();
		}
		
		if (FlxG.keys.justPressed("R"))
		{
			FlxG.resetState();
		}
	}
	
	public function shrapnelHitsBomb(collision:InteractionCallback):Void
	{
		var bomb:Body = cast(collision.int1);
		var shrapnel:Body = cast(collision.int2);
		bomb.cbTypes.add(Registry.CB_Exploding);
	}
	
}