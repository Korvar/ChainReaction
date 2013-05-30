package ;
import nape.dynamics.InteractionFilter;

/**
 * ...
 * @author Mike Cugley
 */
class Explosion extends PhysEmitter
{
	var exploded:Bool = false;

	public function new(X, Y, MaxSize:Int=50) 
	{
		super(X, Y, MaxSize);
		
		minSpeed = 500;
		maxSpeed = 500;
		
		lifespan = 1;
		
		for (i in 0...50)
		{
			var newParticle:PhysParticle = new PhysParticle();

			
			newParticle.makeGraphic(1, 1);
			//newParticle.createCircularBody(1);
			newParticle.exists =  false;
			newParticle.setBodyMaterial(1, 0, 0, 100, 0);
			newParticle.body.setShapeFilters(new InteractionFilter(Registry.FILTER_SHRAPNEL, Registry.FILTER_BOMB + Registry.FILTER_ROCK));
			add(newParticle);
			trace(~Registry.FILTER_SHRAPNEL);
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
			this.callAll("kill");
			kill();
		}
	}
	
}