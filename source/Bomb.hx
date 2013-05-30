package ;
import nape.dynamics.InteractionFilter;
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
	public function new(X:Float=0, Y:Float=0, BombSpeed:Float) 
	{
		super(X, Y, null, false);

		createCircularBody(16);
		body.setShapeMaterials(new Material(1, 0, 0, 1, 0));
		
		body.velocity = Vec2.weak(BombSpeed, 0).rotate(FlxG.random() * 360); // i.e. bombSpeed in a random direction
		loadGraphic("assets/bomb.png");
		body.allowRotation = false; // As it's a circular sprite, with a highlight, don't rotate.
		body.setShapeFilters(new InteractionFilter(Registry.FILTER_BOMB));
		
		
	}
	
}