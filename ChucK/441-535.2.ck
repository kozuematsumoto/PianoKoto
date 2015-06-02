TriOsc osc => JCRev rev => ADSR env => dac;
SawOsc osc2 => JCRev rev2 => ADSR env2 => dac;
TriOsc osc4 => JCRev rev4 => ADSR env4 => dac;
SqrOsc osc6 => JCRev rev6 => ADSR env6 => dac;

SubNoise sNoise =>dac;

0 => osc.gain;
0 => osc2.gain;
0 => osc4.gain;
0 => osc6.gain;

SndBuf kuchinashi => dac;

env.set(0.00001 :: second, 0000.1 :: second, 0.5, 0.1 :: second);
1 => env.keyOn;
env2.set(0.00001 :: second, 0000.1 :: second, 0.5, 0.1 :: second);
1 => env2.keyOn;
env4.set(0.00001 :: second, 0000.1 :: second, 0.5, 0.1 :: second);
1 => env4.keyOn;
env6.set(0.00001 :: second, 0000.1 :: second, 0.5, 0.1 :: second);
1 => env6.keyOn;

osc4.freq(1568);
osc6.freq(203.8);
osc.freq(73.4);
//osc2.freq(587.3);
osc2.freq(1787.3);


sNoise.rate(18);

4.0 => float tempo;
0.3 => float length;
0.2 => float length2;

string path, fileName;
me.dir(-1) => path;

"audio/PianoKoto_441-535.wav" => fileName;

path + fileName => fileName;
fileName => kuchinashi.read;
0 => kuchinashi.pos;


fun void playKuchinashi() {
	while (true) {
		0.95 => kuchinashi.gain;
		0.1::second => now;
	}
}

fun void playBeat() {
	while (true) {
		length-0.3 => float l;
		tempo-l => float tl;
<<< "length: ", length >>>;
		0.02 => osc2.gain;
		0.07:: second => now;
		
		0 => osc2.gain;
		tl::second => now;
			
		0.02 => osc2.gain;
		0.07:: second => now;
			
		0 => osc2.gain;
		l::second => now;

		if (length>(tempo-0.3)) {
			0.3 => length;
		} else {
			length + 0.15 => length;
		}	
	}
}

fun void playBeat2() {
	while (true) {
		length2-0.2 => float l2;
		tempo-l2 => float tl2;

		0.0 => osc4.gain;
		tl2::second => now;

		0.0000001 => osc4.gain;
		0.2:: second => now;
		
		0 => osc4.gain;
		l2::second => now;
		
		0.0000001 => osc4.gain;
		0.2:: second => now;
			
		if (length2>(tempo-0.2)) {
			0.2 => length2;
		} else {
			length2+ 0.15 => length2;
		}	
	}
}

spork ~ playKuchinashi();
spork ~ playBeat();
spork ~ playBeat2();

while (true) {
	0.01 => sNoise.gain;
	0.05 => osc4.gain;
	0.01 => osc6.gain;
	1::second => now;
}
