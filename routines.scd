(
r = Routine { arg inval;
    inval.postln;
    5.do { arg i;
        inval = (i + 10).yield;
        inval.postln;
    }
}
)
(
5.do {
    r.value("hello routine").postln;
};
"finito"
)



(
r = Routine { arg inval;
	inval.postln;
	inval = inval+1;
	inval.yield;
}
)
s = r.value("first");
r.value.postln;


(
t = Task({
    50.do({ arg i;
        i.squared.postln;
        0.5.wait;
    });
});
)

t.start;
t.pause;
t.resume;
t.reset;
t.stop;

// unexpected behavior here
(
t = Task({
    ["go", thisThread.clock.beats].postln;
    inf.do({ arg i;
        2.wait;
        [ "wake up", i ].postln;
    });
});

fork {
    t.start;
    0.1.wait;
    t.stop;
    0.1.wait;
    t.start;
    6.wait;
    t.stop;
};
)

[ go, 1702.114411906 ]
[ go, 1704.114411906 ]