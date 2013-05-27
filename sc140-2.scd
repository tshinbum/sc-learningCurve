play{
	CombL.ar(InFeedback.ar(0),1,1/4,9).sin+
	Pluck.ar(
		ar(n=LFNoise1,400),
		a=LFNoise0.kr(1/2),
		1,
		1/a.abs/200,99) *
	SinOsc.ar(n.kr(1/8)*[6,6s])*0.8
}