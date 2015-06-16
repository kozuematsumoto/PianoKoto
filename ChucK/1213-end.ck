SqrOsc osc => PRCRev rev  => dac;
SqrOsc osc2 => PRCRev rev2  => dac;
SqrOsc osc3 => PRCRev rev3  => dac;
SndBuf kakitsubata => dac;

osc.freq(1568);
osc2.freq(587.33);
osc3.freq(2349.3);

string path, fileName;
me.dir(-1) => path;

"audio/PianoKoto_1213-end.wav" => fileName;

path + fileName => fileName;
fileName => kakitsubata.read;
0 => kakitsubata.pos;


fun void playKakitsubta() {
	while (true) {
		0.95 => kakitsubata.gain;
		0.1::second => now;
	}
}

spork ~ playKakitsubta();

while (true) {
	0.00025 => osc.gain;
	0.0015 => osc2.gain;
	0 => osc3.gain;
	
	30::second => now;
	
	0.00025 => osc.gain;
	0 => osc2.gain;
	
	30::second => now;
	
	0.00025 => osc.gain;
	0.0015 => osc2.gain;
	
	30::second => now;
	
	0.00025 => osc.gain;
	0.0015 => osc2.gain;
	0.0008 => osc3.gain;
	
	30::second => now;
}