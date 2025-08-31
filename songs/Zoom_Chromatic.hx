import funkin.backend.system.Conductor.BeatType;

var _shader:CustomShader = new CustomShader("aberrationCam");
var _shaderIntensity:Float = 0;

function create()
{
    for (cam in [camGame, camHUD]) cam.addShader(_shader);
    scripts.call("onShaderAdd", ["zoom"]);
}

public function zoomChrom() _shaderIntensity = 0.08 * camZoomingStrength;

function update(elapsed:Float)
{
    _shaderIntensity = FlxMath.lerp(_shaderIntensity, 0, elapsed * 6);
    _shader.aberration = _shaderIntensity;
}

// forgive me

function beatHit(e:Int) if (checkForZoom(BeatType.BEAT, e, false)) zoomChrom();

function stepHit(e:Int) if (checkForZoom(BeatType.STEP, e, false)) zoomChrom();

function measureHit(e:Int) if (checkForZoom(BeatType.MEASURE, e, false)) zoomChrom();

function checkForZoom(beatType:BeatType, value:Int, ?custom:Bool = true):Bool
{
    if (camZoomingEvery != beatType && !custom) return;

    return (value - camZoomingOffset) % camZoomingInterval == 0 && camZooming && Options.camZoomOnBeat;
}