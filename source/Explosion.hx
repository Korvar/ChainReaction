package ;
import nape.dynamics.InteractionFilter;
import org.flixel.FlxG;

/**
 * ...
 * @author Mike Cugley
 */
class Explosion extends PhysEmitter
{
	var exploded:Bool = false;

	public function new(X, Y, Speed:Float = 500, Radius:Float = 300, MaxSize:Int=50) 
	{
		super(X, Y, MaxSize);
		
		minSpeed = Speed;
		maxSpeed = Speed;
		
		lifespan = Radius / Speed;
		
		for (i in 0...MaxSize)
		{
			var newParticle:PhysParticle = new PhysParticle();

			
			newParticle.makeGraphic(1, 1, 0xffffffff);
			//newParticle.createCircularBody(1);
			newParticle.exists =  false;
			newParticle.body.setShapeMaterials(Registry.shrapnelMaterial);
			newParticle.body.setShapeFilters(new InteractionFilter(Registry.FILTER_SHRAPNEL, Registry.FILTER_BOMB + Registry.FILTER_ROCK));
			newParticle.body.cbTypes.add(Registry.CB_Shrapnel);
			add(newParticle);
		}
		
	}
	
	public function explode():Void
	{
		start(true, lifespan, 0.1, true);
		exploded = true;
	}
	
	override public function update():Void
	{
		super.update();
		
		if (exploded && countLiving() == 0)
		{
			this.callAll("destroy");
			kill();
			destroy();
		}
	}
	
}