package ;
import nape.callbacks.CbType;
import nme.display.Sprite;
import org.flixel.FlxButton;
import org.flixel.FlxCamera;
import org.flixel.FlxText;

/**
 * ...
 * @author Mike Cugley
 */
class Registry
{

	public static var debugSprite:Sprite;
	
	
	#if debug
	public static var debugString:FlxText;
	#end
	
	public static var worldMinX:Float = 0;
	public static var worldMaxX:Float = 1280;
	public static var worldMinY:Float = 0;
	public static var worldMaxY:Float = 725;


	// CBtypes, should probably rename


	public function new() 
	{
		
	}
	
	public static function clamp(value:Float, min:Float, max:Float):Float
	{
		if(value < min) return min;
		if(value > max) return max;
		return value;
	}
	
}