package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Restoring extends MusicBeatState
{
	var restoring:FlxSprite;

	override function create()
	{
		super.create();

		HeaderCompilationBypass.setWindowTransparency(255);

		var bg:FlxSprite = new FlxSpriteExtra().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		restoring = new FlxSprite();
		restoring.frames = Paths.getSparrowAtlas("restoringsafe");
		restoring.animation.addByPrefix("restoring", "restoring", 24, true);
		restoring.animation.play("restoring");
		restoring.screenCenter();
		restoring.antialiasing = true;
		add(restoring);

	}

	var timeLeft:Float = 7.77;

	override function update(elapsed:Float)
	{
		if(timeLeft > 0) {
			timeLeft -= elapsed;
			if(timeLeft <= 0) {
				FlxTween.tween(restoring, {alpha: 0}, 1, {onComplete: (_) -> {
					MusicBeatState.switchState(new MainMenuState());
				}});
			}
		}
		super.update(elapsed);
	}
}
