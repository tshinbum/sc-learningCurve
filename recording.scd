s.boot;
// 4) =========  Recording into a buffer  ==========

b = Buffer.alloc(s, 44100 * 8.0, 1); // 8 second mono buffer

(
SynthDef(\recBuf,{ arg out=0, bufnum=0;
	var in;
	in = AudioIn.ar(1);
	RecordBuf.ar(in, bufnum);
}).load(s);
)

// we record into the buffer
x = Synth(\recBuf, [\out, 0, \bufnum, b.bufnum]);
x.free;

// and we can play it back using the playBuf synthdef we created above
z = Synth(\playBuf, [\bufnum, b.bufnum])
z.free;

// if we like it, we can write it to disk as a soundfile:
b.write("myBufRecording.aif", "AIFF", 'int16');


Quarks.gui;