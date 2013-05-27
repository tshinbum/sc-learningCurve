(
    {
	Pluck.ar(
		WhiteNoise.ar(0.1),
		Impulse.kr(2),
		440.reciprocal,
		440.reciprocal,
		1,
        coef:MouseX.kr(-0.999, 0.999))
    }.play(s)
)

(
SynthDef(\string, {arg out=0, freq=440, pan=0, sustain=0.5, amp=0.3;
	var pluck, period, string;
	pluck = PinkNoise.ar(Decay.kr(Impulse.kr(0.005), 0.05));
	period = freq.reciprocal;
	string = CombL.ar(pluck, period, period, sustain*6);
	string = LeakDC.ar(LPF.ar(Pan2.ar(string, pan), 12000)) * amp;
	DetectSilence.ar(string, doneAction:2);
	Out.ar(out, string)
}).add;


fork{
	inf.do({
		4.rand.do({
			Synth(\string,
				[
					\freq,
					[60, 67, 64, 72, 58].choose.midicps,
					\sustain,
					rrand(1.0, 2.0)]);
			0.2.rand.wait;
		});
		[0.2, 0.4].choose.wait;
	})
}
)

// Digital little doggies
play{
	p=Impulse.ar(2,[1/3,0]);
	d=Demand.ar(
		p,
		0,
		Dseq([0,4,7,4,1,4,7,4,2,5,7,5,2,5,7,5],inf)).midicps*16;
	Pluck.ar(PinkNoise.ar,p,1,1/d,3).sum
}


//Nathaniel's Black Sabbath tweet:
Ndef(\,
	{
		CombN.ar(
			BPF.ar(
				Saw.ar(1/8)*1e5+CuspN.ar*1e-3-Ndef(\).ar/40,200,4),
			1,
			LFNoise0.ar(1/8).lag+2/[2.02,3]/99++4,9).sum.tanh!2
	}
).play