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

	public function new(X, Y, MaxSize:Int = 0)
	{
		super(MaxSize);
		x = X;
		y = Y;
	}
	
	public function emitParticle():Void
	{
		if (!on) return;
		var particle:PhysParticle = cast(recycle(PhysParticle));
		var emitVelocity:Vec2 = new Vec2(1, 0);
		
		if (maxSpeed < minSpeed) maxSpeed = minSpeed;
		
		if (maxAngle <= 0) maxAngle = 360;
		
		var emitSpeed:Float = (FlxG.random() * (maxSpeed - minSpeed)) + minSpeed;
		var emitAngle:Float = (FlxG.random() * (maxAngle - minAngle)) + minAngle;
		emitAngle = Math.PI * emitAngle / 180;  // Convert to radians

		emitVelocity.muleq(emitSpeed);
		emitVelocity.rotate(emitAngle);
		
		particle.reset(x, y);
		particle.body.velocity = emitVelocity;
		particle.lifespan = lifespan;
		// particle.visible = true;
		
		emitVelocity.dispose();
	}
	
	public function setSpread(Angle, Spread)
	{
		minAngle = Angle - (Spread / 2);
		maxAngle = Angle + (Spread / 2);
	}
	
	public function start(Explode:Bool = true, Lifespan:Float = 1, Rate:Float = 1):Void
	{

		lifespan = Lifespan;		
		on = true;
		
		if (Explode)
		{
			for (i in this.members)
			{
				emitParticle();
			}
			on = false;
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