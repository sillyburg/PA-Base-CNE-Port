var noteT:String = "Glitch Note"; // replace to the note's name

var _timer:FlxTimer;
var _shader:CustomShader = new CustomShader("distort");
var defaultOpponentStrums:Array<Float, Float> = [];

function postCreate()
{
    _shader.negativity = 1;

    for (i in cpuStrums.members)
        defaultOpponentStrums.push([i.x, i.y]);
}

function onNoteHit(e:NoteHitEvent)
{
    if (e.noteType != noteT) return;
    if (e.note.isSustainNote) return;

    var characters:Array<Character> = e.characters;
    var time:Float = e.note.nextNote.isSustainNote ? e.note.nextNote.sustainLength / 1000 : 0;
    var randomTime:Float = FlxG.random.float(0.0475, 0.085);

    _shader.binaryIntensity = FlxG.random.float(-1, -0.5);

    for (char in characters) char.shader = _shader;
    scripts.call("onGlitchChar", characters);
    
    for (_ => i in cpuStrums.members) i.setPosition(
        defaultOpponentStrums[_][0] + FlxG.random.float(-8, 8),
        defaultOpponentStrums[_][1] + FlxG.random.float(-8, 8)
    );

    _timer?.cancel();

    _timer = new FlxTimer().start(time + randomTime, _ -> {
        for (char in characters) char.shader = null;
        scripts.call("onUnglitchChar", characters);
    });
}