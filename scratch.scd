s.boot;
"open -a 'Audio MIDI Setup'".unixCmd; // execute this to launch it
"pwd".unixCmd;
"/Users/schoen/Documents".dirname;


~houston = Buffer.read(s, "/Users/schoen/Documents/02_DatenDieter/SuperCollider/BookExamples/Ch 1 Tutorial/sounds/a11wlk01-44_1.aiff");

~chouston = Buffer.read(s, "/Users/schoen/Documents/02_DatenDieter/SuperCollider/BookExamples/Ch 1 Tutorial/sounds/a11wlk01.wav");

{PlayBuf.ar(1, ~houston)}.plot;

{BMoog.ar(PlayBuf.ar(1, ~houston),1200,1.3,0.4)}.play;

Quarks.gui;

XiiLang();