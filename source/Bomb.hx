package ;
import nape.geom.Vec2;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;
import org.flixel.FlxG;
import org.flixel.nape.FlxPhysSprite;

/**
 * ...
 * @author Mike Cugley
 */
class Bomb extends FlxPhysSprite
{

	public function new(X:Float=0, Y:Float=0, SimpleGraphic:Dynamic=null, CreateBody:Bool=true) 
	{
		super(X, Y, SimpleGraphic, false);

		createCircularBody(16);
		body.setShapeMaterials(new Material(1, 0, 0, 1, 0));
		
		body.velocity = Vec2.weak(70, 0).rotate(FlxG.random() * 360); // i.e. Speed 50 in a random direction
		loadGraphic("assets/bomb.png");
		body.allowRotation = false; // As it's a circular sprite, with a highlight, don't rotate.
		
		
	}
	
}