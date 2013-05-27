(
SynthDef(\ds1,
	{
		arg freq = 440, dur=2, vibratofreq=0;
		var out;
		out = SinOsc.ar(freq*SinOsc.kr(vibratofreq,pi/2),0,
			Linen.kr(Impulse.kr(0),dur * 0.1,0.6,dur*0.9,doneAction:2));
		Out.ar(1, out)
	}
).add
)


x = Synth(\ds1, ["freq", 550]);
(instrument:\ds1, freq: 345, dur:1.0).play
(instrument:\ds1, freq: 3245, dur:5.0).play
(instrument:\ds1, freq: 8115, dur:12.0,vibratofreq:311).play
Task
Routine


---------------------------------------------
// trigged
(
SynthDef("help-Linen",{ arg out = 0;
    Out.ar(out,
        Linen.kr(Impulse.kr(2), 0.01, 0.6, 1.0, doneAction: 0) * SinOsc.ar(440, 0, 0.1)
    )
}).play;
)

// play once and end the synth
(
SynthDef("help-Linen",
	{
		arg out=0;
		    Out.ar(out,
			        Linen.kr(
				Impulse.kr(0),
				0.01,
				0.6,
				1.0,
				doneAction: 2) * SinOsc.ar(440, 0, 0.1)
		    )
}).play;
)

// play once and sustain
(
x = SynthDef("help-Linen",{ arg gate = 1, out = 0; // use gate arg for release
    Out.ar(out,
        Linen.kr(gate, 0.01, 0.6, 1.0, doneAction: 2) * SinOsc.ar(440, 0, 0.1)
    )
}).play;
)
x.release(4); // change the release time

// longer gate, can pass in duration
(
SynthDef("help-Linen",{ arg out = 0, dur = 0.1;
    var gate;
    gate = Trig.kr(1.0, dur);
    Out.ar(out,
        Linen.kr(gate, 0.01, 0.6, 1.0, doneAction: 2) * SinOsc.ar(440, 0, 0.1)
    )
}).play(nil, [\out, 0, \dur, 2.0]);
)



// used below in a Routine varying the releaseTime
(
SynthDef("help-Linen",{ arg out=0,freq=440,attackTime=0.01,susLevel=0.6,releaseTime=0.1;
    Out.ar(out,
        Linen.kr(Impulse.kr(0), attackTime, susLevel, releaseTime, doneAction: 2)
            * SinOsc.ar(freq, 0, 0.1)
    )
}).send(s);
)

(
// debussey sleeping through math class
x = Pbrown(0.01, 2.0, 0.2, inf).asStream;
Routine({
    loop({
        Synth.grain("help-Linen",[\freq, (rrand(20, 50) * 2).midicps, \releaseTime, x.next]);
        0.25.wait;
    })
}).play(TempoClock.default)
)





(
SynthDef("help-Linen",{ arg out = 0;
    Out.ar(out,

        Linen.kr(Impulse.kr(2),
            0.01,
            // sustain level is polled at time of trigger
            FSinOsc.kr(0.1).range(0, 1),
            1.0,
            doneAction: 0)

            * SinOsc.ar(440, 0, 0.1)
    )
}).play;
)