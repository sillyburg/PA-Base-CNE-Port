var _shader:CustomShader = new CustomShader("Pibbified");
var _shaderIntensity:Float = 0;

_shader.iMouseX = 500;
_shader.NUM_SAMPLES = 3;

function create()
{
    for (cam in [camGame, camHUD]) cam.addShader(_shader);
    scripts.call("onShaderAdd", ["sing"]);
}

function onDadHit(e:NoteHitEvent)
{
    if (FlxG.random.bool(50)) return;

    _shaderIntensity = FlxG.random.float(0.2, 0.7);

    scripts.call("onSingChrom");
}

function update(elapsed:Float)
{
    _shaderIntensity = FlxMath.lerp(_shaderIntensity, 0, elapsed * 7);
    _shader.glitchMultiply = _shaderIntensity;
}