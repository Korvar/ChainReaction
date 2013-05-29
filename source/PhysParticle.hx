package ;

import nape.phys.Material;
import org.flixel.FlxG;
import org.flixel.nape.FlxPhysSprite;

/**
 * ...
 * @author Mike Cugley
 */
class PhysParticle extends FlxPhysSprite
{
	public var lifespan:Float;

	public function new(X:Float=0, Y:Float=0, SimpleGraphic:Dynamic=null, CreateBody:Bool=true) 
	{
		super(X, Y, SimpleGraphic, false);
		makeGraphic(1, 1);
		createCircularBody(1);
		setBodyMaterial(1, 0, 0, 1, 0);
		
		
	}
	
	override public function update():Void
	{
		if (lifespan <= 0)
		{
			return;
		}
		lifespan -= FlxG.elapsed;
		if (lifespan <= 0)
		{
			kill();
		}
		
		super.update();
		
	}
	
	override public function reset(X, Y)
	{
		super.reset(X, Y);
		body.position.x = X;
		body.position.y = Y;
	}
	
}