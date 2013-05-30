package ;
import nape.geom.Vec2;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.nape.FlxPhysSprite;

/**
 * ...
 * @author Mike Cugley
 */
class PhysEmitter extends FlxGroup
{
	var x:Float;
	var y:Float;
	

	
	public var rate:Float = 1.0; // How fast the particles should be emitted
	var timeSinceLastEmit:Float = 0;
	
	public var lifespan:Float = 1; // lifespan of the particles
	
	public var minAngle:Float = 0.0; // Minimum angle of velocity vector
	public var maxAngle:Float = 360.0; // Maximum angle of velocity vector
	public var minSpeed:Float = 0; // minimum velocity of particle
	public var maxSpeed:Float = 10; // maximum velocity of particle
	
	public var on:Bool = false;
	var exploding:Bool = true;
	var regular:Bool; // Whether the explosion is regular i.e. non-randomly distributed	

	public function new(X, Y, MaxSize:Int = 0)
	{
		super(MaxSize);
		x = X;
		y = Y;
	}
	
	public function emitParticle():Void
	{
		if (!on) return;
		var particle:PhysParticle = cast(getFirstAvailable(), PhysParticle);
		var emitVelocity:Vec2 = Vec2.get(1, 0);
		
		if (maxSpeed < minSpeed) maxSpeed = minSpeed;
		
		if (maxAngle <= 0) maxAngle = 360;
		
		var emitSpeed:Float = (FlxG.random() * (maxSpeed - minSpeed)) + minSpeed;
		var emitAngle:Float = (FlxG.random() * (maxAngle - minAngle)) + minAngle;
		emitAngle = Math.PI * emitAngle / 180;  // Convert to radians

		emitVelocity.muleq(emitSpeed);
		emitVelocity.rotate(emitAngle);

		particle.body.velocity = emitVelocity;
		particle.lifespan = lifespan;
		particle.visible = true;
		particle.reset(x, y);  
		
		emitVelocity.dispose();
	}
	
	public function setSpread(Angle, Spread)
	{
		minAngle = Angle - (Spread / 2);
		maxAngle = Angle + (Spread / 2);
	}
	
	public function start(Explode:Bool = true, Lifespan:Float = 1, Rate:Float = 1, Regular:Bool = false):Void
	{

		lifespan = Lifespan;		
		on = true;
		
		if (Explode)
		{
			exploding = true;
			var angleStep:Float = 0;
			var originalMaxAngle:Float = 0;
			var originalMinAngle:Float = 0;
			var angleIncrement:Float = 0;
			if (Regular) 
			{
				angleStep = (maxAngle - minAngle) / members.length;
				originalMaxAngle = maxAngle;
				originalMinAngle = minAngle;			
			}
			for (i in this.members)
			{
				if (Regular)
				{
					minAngle = maxAngle = originalMinAngle + angleIncrement;
					angleIncrement += angleStep;
				}
				emitParticle();
			}
			on = false;
			if (Regular)
			{
				minAngle = originalMinAngle;
				maxAngle = originalMaxAngle;
			}
		}
		else 
		{
			timeSinceLastEmit = 0;
			rate = Rate;
		}
	}
	
	override public function update()
	{
		super.update();
		
		timeSinceLastEmit += FlxG.elapsed;
		if (timeSinceLastEmit >= rate)
		{
			timeSinceLastEmit -= rate;
			emitParticle();
		}
		
	}
	
}