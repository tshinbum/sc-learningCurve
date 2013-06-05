

b = Buffer.alloc(s, 1024, 1); // for sampling rates 44100 and 48000

(
{
var in, fft, loudness;

	in = SinOsc.ar(1000, 0, MouseX.kr(0.001,1,'exponential')); //should be 1 sone
//in = SinOsc.ar(1000, 0, 0.01); //should be 4 sone
//in = SinOsc.ar(1000, 0, 0.1); //should be 16 sone
//in = SinOsc.ar(1000, 0, 1); //should be 64 sone
//in = Saw.ar * SinOsc.ar(4);
//in = WhiteNoise.ar;
//in = Silent.ar; // should be small, around 2 ** ((0 - 40) / 10) = 2 ** (-4) = 0.0625
//in = DC.ar(1);
//in = SinOsc.ar(22050, pi * 0.5, 1);
// fade ins
//in = SinOsc.ar(1000, 0, Line.kr(0, 1, 2));
//in = SinOsc.ar(1000, 0, Line.kr(0, 1, 2) ** 2);
//in = WhiteNoise.ar(Line.kr(0, 1, 2));
//in = PlayBuf.ar(1, d, BufRateScale.kr(d), 1, 0, 1);

fft = FFT(b, in);

loudness = Loudness.kr(fft, 0.25, 6).poll(50);

Out.ar(0, Pan2.ar(in));
K2A.ar(loudness * 0.016)
}.plot(2.0)
)


(
{
var in, fft, loudness;

in = SinOsc.ar(1000, 0, MouseX.kr(0.001,1,'exponential')); //should be 1 sone
fft = FFT(b, in);
loudness = Loudness.kr(fft, 0.25, 6).poll(50);

Out.ar(0, Pan2.ar(in));
}.play;
)

SynthDef(\sin, { arg freq=440;
	Out.ar(0,SinOsc.ar(freq))
}).add;
Synth(\sin,[\freq, 880]);

Window.screenBounds().width
// GUI
(
SynthDef(\sin, { arg freq=440;
	Out.ar(0,SinOsc.ar(freq))
}).send;


{
	var w, b, freq, vol, pan, freqVal, volVal, panVal;
	var screen = Window.screenBounds();
	w = Window.new("Hoertest", Window.screenBounds(),false,false);
	//b = Button.new(w,Rect(10,0,80,30)).states_([["Start"],["Stop"]]);

	StaticText.new(w,Rect(0,0,80,30)).string_("Frequenz");
	freqVal = StaticText.new(w,Rect(600,0,80,30)).string_("0");
	freq = Slider.new(w,Rect(95, 0,500,30))
	       .action_({ var frequency;
		              frequency = freq.value*(25000.log).exp;
		              freqVal.string = (frequency).asString;
		              Synth(\sin,[\freq, frequency])
		            });

	StaticText.new(w,Rect(0,35,80,30)).string_("Lautstärke");
	volVal = StaticText.new(w,Rect(600,35,80,30)).string_("0");
	vol  = Slider.new(w,Rect(95,35,500,30))
	       .action_({ volVal.string = vol.value.asString });

	StaticText.new(w,Rect(0,70,80,30)).string_("Richtung");
	panVal = StaticText.new(w,Rect(600,70,80,30)).string_("0");
	pan  = Slider.new(w,Rect(95,70,500,30))
	       .action_({ panVal.string = (pan.value * 2 - 1).asString })
	       .value_(0.5);



	// c = CompositeView.new(w,Rect(20,35,100,60));
	// StaticText.new(c,Rect(0,0,80,30)).string_("Hello");
	// StaticText.new(c,Rect(20,30,80,30)).string_("World!");
	// b.action = { c.visible = b.value.asBoolean.not };
	// s.action = { c.bounds = Rect( s.value * 150 + 20, 35, 100, 100 ) };
	// w.front;
	// p = Plotter("nurx",Rect(20,100,200,200),w);
	// p.value = (0..1000).normalize(0, 14pi).curdle(0.01).scramble.flat.sin;
	w.front;
	CmdPeriod.doOnce({w.close});

}.value;
)

24000.log
(0..1)*(25000.log).exp
Pan2
SynthDef