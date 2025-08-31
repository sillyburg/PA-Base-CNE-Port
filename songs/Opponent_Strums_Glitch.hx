function postCreate() for (i in cpuStrums.members)
{
    i.shader = new CustomShader("distort");
    if (i.shader != null) i.shader.negativity = 0;
}

function stepHit()
{
    for (_ => i in cpuStrums.members)
        if (i.shader != null)
        {
            i.shader.binaryIntensity = FlxG.random.float(4, 6);
            scripts.call("onStrumGlitchUpdate", _);
        }
}