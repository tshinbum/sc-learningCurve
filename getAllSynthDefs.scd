SynthDescLib.global.synthDescs.do { |desc|
        if(desc.def.notNil) {
                "\nSynthDef %\n".postf(desc.name.asCompileString);
                desc.def.func.postcs;
        };
}; 