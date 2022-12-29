package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;
	public var noteType:Int = 0;

	public var mustPress:Bool = false;
	public var burning:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	
	public var dType:Int = 0;

	public var rating:String = "shit";

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0)
		{
			super();
 
			if (prevNote == null)
				prevNote = this;
			this.noteType = noteType;
			this.prevNote = prevNote;
			isSustainNote = sustainNote;
 
			x += 50;
			// MAKE SURE ITS DEFINITELY OFF SCREEN?
			y -= 2000;
			this.strumTime = strumTime;
 
			if (this.strumTime < 0 )
				this.strumTime = 0;
 
			this.noteData = noteData;
 
			var daStage:String = PlayState.curStage;
 
			switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels','week2'), true, 17, 17);
 
					if (noteType == 2)
						{
							animation.add('greenScroll', [22]);
							animation.add('redScroll', [23]);
							animation.add('blueScroll', [21]);
							animation.add('purpleScroll', [20]);
						}
					else
						{
							animation.add('greenScroll', [6]);
							animation.add('redScroll', [7]);
							animation.add('blueScroll', [5]);
							animation.add('purpleScroll', [4]);
						}
 
					if (isSustainNote)
					{
						loadGraphic(Paths.image('weeb/pixelUI/arrowEnds','week6'), true, 7, 6);
 
						animation.add('purpleholdend', [4]);
						animation.add('greenholdend', [6]);
						animation.add('redholdend', [7]);
						animation.add('blueholdend', [5]);
 
						animation.add('purplehold', [0]);
						animation.add('greenhold', [2]);
						animation.add('redhold', [3]);
						animation.add('bluehold', [1]);
					}
 
					setGraphicSize(Std.int(width * PlayState.daPixelZoom));
					updateHitbox();
				case 'ace':
						frames = Paths.getSparrowAtlas('weeb/pixelUI/aceNOTE_assets2','week2');
						var fuckingSussy = Paths.getSparrowAtlas('PumpkinNote');
						for(amogus in fuckingSussy.frames)
							{
								this.frames.pushFrame(amogus);
							} 
 
						switch(noteType)
						{
							case 2:
							{
								frames = Paths.getSparrowAtlas('PumpkinNote');
								animation.addByPrefix('greenScroll', 'Note');
								animation.addByPrefix('redScroll', 'Note');
								animation.addByPrefix('blueScroll', 'Note');
								animation.addByPrefix('purpleScroll', 'Note');
 
/*								animation.addByPrefix('purpleholdend', 'purple fire');
								animation.addByPrefix('greenholdend', 'green fire');
								animation.addByPrefix('redholdend', 'red fire');
								animation.addByPrefix('blueholdend', 'blue fire');
 
								animation.addByPrefix('purplehold', 'purple fire');
								animation.addByPrefix('greenhold', 'green fire');
								animation.addByPrefix('redhold', 'red fire');
								animation.addByPrefix('bluehold', 'blue fire');
*/ 
								setGraphicSize(Std.int(width * 0.35));
								updateHitbox();
								antialiasing = true;
							}
							
							case 3:
							{
								frames = Paths.getSparrowAtlas('dangerarrow');
								
								animation.addByPrefix('greenScroll', 'yellow0000');
								animation.addByPrefix('redScroll', 'yellow0000');
								animation.addByPrefix('blueScroll', 'yellow0000');
								animation.addByPrefix('purpleScroll', 'yellow0000');
 
								animation.addByPrefix('purpleholdend', 'yellow hold end');
								animation.addByPrefix('greenholdend', 'yellow hold end');
								animation.addByPrefix('redholdend', 'yellow hold end');
								animation.addByPrefix('blueholdend', 'yellow hold end');
 
								animation.addByPrefix('purplehold', 'yellow hold piece0000');
								animation.addByPrefix('greenhold', 'yellow hold piece0000');
								animation.addByPrefix('redhold', 'yellow hold piece0000');
								animation.addByPrefix('bluehold', 'yellow hold piece0000');

								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
							default:
							{
								frames = Paths.getSparrowAtlas('weeb/pixelUI/aceNOTE_assets2','week2');
								animation.addByPrefix('greenScroll', 'black');
								animation.addByPrefix('redScroll', 'black');
								animation.addByPrefix('blueScroll', 'black');
								animation.addByPrefix('purpleScroll', 'black');
 
								animation.addByPrefix('purpleholdend', 'end hold black');
								animation.addByPrefix('greenholdend', 'end hold black');
								animation.addByPrefix('redholdend', 'end hold black');
								animation.addByPrefix('blueholdend', 'end hold black');
 
								animation.addByPrefix('purplehold', 'piece hold black');
								animation.addByPrefix('greenhold', 'piece hold black');
								animation.addByPrefix('redhold', 'piece hold black');
								animation.addByPrefix('bluehold', 'piece hold black');
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
						}
					case 'flame':
						
/*						var fuckingSussy = Paths.getSparrowAtlas('PumpkinNote');
						for(amogus in fuckingSussy.frames)
							{
								this.frames.pushFrame(amogus);
							} 
*/ 
						switch(noteType)
						{
/*							case 2:
							{
								frames = Paths.getSparrowAtlas('PumpkinNote');
								animation.addByPrefix('greenScroll', 'Note');
								animation.addByPrefix('redScroll', 'Note');
								animation.addByPrefix('blueScroll', 'Note');
								animation.addByPrefix('purpleScroll', 'Note');
 
/*								animation.addByPrefix('purpleholdend', 'purple fire');
								animation.addByPrefix('greenholdend', 'green fire');
								animation.addByPrefix('redholdend', 'red fire');
								animation.addByPrefix('blueholdend', 'blue fire');
 
								animation.addByPrefix('purplehold', 'purple fire');
								animation.addByPrefix('greenhold', 'green fire');
								animation.addByPrefix('redhold', 'red fire');
								animation.addByPrefix('bluehold', 'blue fire');

								setGraphicSize(Std.int(width * 0.35));
								updateHitbox();
								antialiasing = true;
							}
*/							default:
							{
								frames = Paths.getSparrowAtlas('NOTE_assets_Circles','week3');
								animation.addByPrefix('greenScroll', 'black');
								animation.addByPrefix('redScroll', 'black');
								animation.addByPrefix('blueScroll', 'black');
								animation.addByPrefix('purpleScroll', 'black');
 
								animation.addByPrefix('purpleholdend', 'end hold black');
								animation.addByPrefix('greenholdend', 'end hold black');
								animation.addByPrefix('redholdend', 'end hold black');
								animation.addByPrefix('blueholdend', 'end hold black');
 
								animation.addByPrefix('purplehold', 'piece hold black');
								animation.addByPrefix('greenhold', 'piece hold black');
								animation.addByPrefix('redhold', 'piece hold black');
								animation.addByPrefix('bluehold', 'piece hold black');
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
						}
				default:
						frames = Paths.getSparrowAtlas('NOTE_assets');
						var fuckingSussy = Paths.getSparrowAtlas('NOTE_fire');
						for(amogus in fuckingSussy.frames)
							{
								this.frames.pushFrame(amogus);
							}
 
						switch(noteType)
						{
							case 2:
							{
								frames = Paths.getSparrowAtlas('NOTE_fire');
								animation.addByPrefix('greenScroll', 'green fire');
								animation.addByPrefix('redScroll', 'red fire');
								animation.addByPrefix('blueScroll', 'blue fire');
								animation.addByPrefix('purpleScroll', 'purple fire');
 
								animation.addByPrefix('purpleholdend', 'purple fire');
								animation.addByPrefix('greenholdend', 'green fire');
								animation.addByPrefix('redholdend', 'red fire');
								animation.addByPrefix('blueholdend', 'blue fire');
 
								animation.addByPrefix('purplehold', 'purple fire');
								animation.addByPrefix('greenhold', 'green fire');
								animation.addByPrefix('redhold', 'red fire');
								animation.addByPrefix('bluehold', 'blue fire');
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
							default:
							{
								frames = Paths.getSparrowAtlas('NOTE_assets');
								animation.addByPrefix('greenScroll', 'green0');
								animation.addByPrefix('redScroll', 'red0');
								animation.addByPrefix('blueScroll', 'blue0');
								animation.addByPrefix('purpleScroll', 'purple0');
 
								animation.addByPrefix('purpleholdend', 'pruple end hold');
								animation.addByPrefix('greenholdend', 'green hold end');
								animation.addByPrefix('redholdend', 'red hold end');
								animation.addByPrefix('blueholdend', 'blue hold end');
 
								animation.addByPrefix('purplehold', 'purple hold piece');
								animation.addByPrefix('greenhold', 'green hold piece');
								animation.addByPrefix('redhold', 'red hold piece');
								animation.addByPrefix('bluehold', 'blue hold piece');
 
								setGraphicSize(Std.int(width * 0.7));
								updateHitbox();
								antialiasing = true;
							}
						}
			}
 
		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}

		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}


				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed;
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

/*	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		//No held fire notes :[ (Part 2)
		if(isSustainNote && prevNote.burning) { 
			this.kill(); 
		
		if (mustPress)
		{
			// ass
			if (isSustainNote)
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + Conductor.safeZoneOffset)
					canBeHit = true;
				else
					canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
*/
override function update(elapsed:Float)
	{
		super.update(elapsed);

		//No held fire notes :[ (Part 2)
		if(isSustainNote && prevNote.burning) { 
			this.kill(); 
		}

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (!burning)
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (PlayState.curStage == 'auditorHell') // these though, REALLY hard to hit.
				{
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.3)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.2)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
				else
				{
				// make burning notes a lot harder to accidently hit because they're weirdchamp!
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.6)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.4)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
			}
			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}