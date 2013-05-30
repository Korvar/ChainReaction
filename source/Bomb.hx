package ;
import nape.callbacks.CbTypeList;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;
import org.flixel.FlxG;
import org.flixel.FlxTimer;
import org.flixel.nape.FlxPhysSprite;

/**
 * ...
 * @author Mike Cugley
 */
class Bomb extends FlxPhysSprite
{
	var exploding:Bool = false;
	var fuseTime:Float = 2; // detonation time in seconds
	
	public function new(X:Float=0, Y:Float=0, BombSpeed:Float, FuseTime:Float = 2) 
	{
		super(X, Y, null, false);

		fuseTime = FuseTime;
		
		createCircularBody(16);
		body.setShapeMaterials(Registry.bombMaterial);
		
		body.velocity = Vec2.weak(BombSpeed, 0).rotate(FlxG.random() * 360); // i.e. bombSpeed in a random direction
		loadGraphic("assets/bomb.png");
		body.allowRotation = false; // As it's a circular sprite, with a highlight, don't rotate.
		body.setShapeFilters(new InteractionFilter(Registry.FILTER_BOMB));
		
		body.cbTypes.add(Registry.CB_Bomb);
		
	}
	
	override public function update():Void
	{
		super.update();
		if (body.cbTypes.has(Registry.CB_Exploding) && !exploding)
		{
			// I.E. have we just been hit by shrapnel.
			// Start ze countdown!
			
			// Start the flashing animation that I haven't created yet.
			
			// Create a timer.
			var bombTimer:FlxTimer = new FlxTimer();
			bombTimer.start(fuseTime, 1, explode);
			exploding = true;
		}
	}
	
	public function explode(timer:FlxTimer)
	{
		var newExplosion:Explosion = new Explosion(x, y, 500, 150);
		kill();
		FlxG.state.add(newExplosion);
		newExplosion.explode();	
		
	}
}