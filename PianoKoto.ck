SndBuf pianoKoto => dac;
SndBuf piano => PitchTrack pitchP => blackhole;
SndBuf koto => PitchTrack pitchK => blackhole;

// Sound file location
string path, filename, filenameP, filenameK;
me.dir() => path;

"/pianoKotoWork.wav" => filename;
"/pianoWork.wav" => filenameP;
"/kotoWork.wav" => filenameK;

path + filename => filename;
path + filenameP => filenameP;
path + filenameK => filenameK;

filename => pianoKoto.read;
filenameP => piano.read;
filenameK => koto.read;
//pianoKoto.samples() => pianoKoto.pos;

10000000=> pianoKoto.pos;         
10000000=> piano.pos;         
10000000=> koto.pos;         

// Osc output
OscOut osc;

// Creat osc message
OscMsg msg;

osc.dest("127.0.0.1", 12001);

// Variables to store location 
fun void PianoKoto() {
	while(true) {
		
		// Set up the volume
		0.5 => pianoKoto.gain;            
//		0.5 => piano.gain;            
//		0.5 => koto.gain;            
		
		// Move time 
		0.1::second => now;
	}
}


while (true) {

	100::ms => now;
	pitchP.get() => float pianoPitch;
	pitchK.get() => float kotoPitch;
			<<< "pianoPitch: ", pianoPitch >>>;
			<<< "kotoPitch: ", kotoPitch >>>;

	100::ms => now;
	oscOut("/pianoPitch", pianoPitch);
	oscOut("/kotoPitch", kotoPitch);
		
}

spork ~ PianoKoto();

// Osc sending function
fun void oscOut(string addr, float val) {
	//	<<<"val: " , val >>>;
	osc.start(addr);
	osc.add(val);
	osc.send();
}




