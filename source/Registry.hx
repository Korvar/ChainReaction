package ;
import nape.callbacks.CbType;
import nape.phys.Material;
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
	public static var worldMaxY:Float = 800;


	// Interaction Filters
	public static var FILTER_SHRAPNEL:Int = 1;
	public static var FILTER_BOMB:Int = 2;
	public static var FILTER_ROCK:Int = 4;

	// CbTypes
	public static var CB_Shrapnel:CbType;
	public static var CB_Bomb:CbType;
	public static var CB_Exploding:CbType;
	
	public static var shrapnelMaterial:Material;
	public static var bombMaterial:Material;
	public static var rockMaterial:Material;
	public static var wallmaterial:Material;
	
	
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