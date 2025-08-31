var intensity:Float = 25;
var angleIntensity = 1;

var _angle:Float = 0;

function onNoteHit(e:NoteHitEvent)
{
    switch (e.direction)
    {
        case 0: setOffset([-intensity, 0, -angleIntensity]);
        case 1: setOffset([0, intensity, 0]);
        case 2: setOffset([0, -intensity, 0]);
        case 3: setOffset([intensity, 0, angleIntensity]);
    }
}

function update(elapsed:Float)
{
    if (strumLines.members[curCameraTarget] != null)
        if (!StringTools.startsWith(strumLines.members[curCameraTarget].characters[0].animation.curAnim.name, 'sing'))
            setOffset([0, 0]);

    camGame.angle = FlxMath.lerp(camGame.angle, _angle, camGame.followLerp);
}

function setOffset(posArray:Array<Float, Float, Float>)
{
    camGame.targetOffset.set(posArray[0], posArray[1]);
    _angle = posArray[2];
}