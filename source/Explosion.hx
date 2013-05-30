package ;

/**
 * ...
 * @author Mike Cugley
 */
class Explosion extends PhysEmitter
{
	var exploded:Bool = false;

	public function new(X, Y, MaxSize:Int=0) 
	{
		super(X, Y, 50);
		
		minSpeed = 300;
		maxSpeed = 300;
		
		lifespan = 1;
		
		for (i in 0...50)
		{
			var newParticle:PhysParticle = new PhysParticle();

			
			newParticle.makeGraphic(1, 1);
			//newParticle.createCircularBody(1);
			newParticle.exists =  false;
			newParticle.setBodyMaterial(1, 0, 0, 100, 0);
			add(newParticle);
		}
		
	}
	
	public function explode():Void
	{
		start(true, lifespan, 0.1);
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