(
var p, l;
p = Pipe.new("ls -l", "r");            // list directory contents in long format
l = p.getLine;                    // get the first line
while(
	{
		l.notNil
	},
	{
		l.postln;
		l = p.getLine;
	}
);
// post until l = nil
p.close;
// close the pipe to avoid that nasty buildup
)



// 4) =========  Recording into a buffer  ==========

b = Buffer.alloc(s, 44100 * 8.0, 1); // 8 second mono buffer

(
SynthDef(\recBuffo,{ arg out=0, bufnum=0;
	var in;
	in = AudioIn.ar(1);
	RecordBuf.ar(in, bufnum);
}).load(s);
)

// we record into the buffer
x = Synth(\recBuffo, [\out, 0, \bufnum, b.bufnum]);
x.free;

// and we can play it back using the playBuf synthdef we created above
z = Synth(\playBuf, [\bufnum, b.bufnum]);

z.free;

// if we like it, we can write it to disk as a soundfile:
b.write("adrian_ene_mene.aif", "AIFF", 'int16');

b.free;

b.bufnum

(
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, b.bufnum, BufRateScale.kr(b.bufnum), doneAction:2)
    )
}).play(s, [\out, 0, \bufnum, b]);
)


SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
    var rate;
    rate = MouseX.kr(0.1, 100, 1);
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, 1.0, 0.0, 1.0)
    )
}).play(s, [\out, 0, \bufnum, b]);

s.makeGui;