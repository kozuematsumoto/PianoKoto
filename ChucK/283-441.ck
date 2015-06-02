SawOsc osc => JCRev rev0 =>dac;
SawOsc osc3 => JCRev rev3 =>dac;
SawOsc osc4 => JCRev rev4 =>dac;
SubNoise noise =>dac;
Shakers shak => PRCRev rev => dac;

SndBuf daidai => dac;

osc3.freq(87.3);
osc4.freq(55);
noise.rate(13);

shak.controlChange(1, 1500);
shak.controlChange(2, 128);
shak.controlChange(4, 120);
shak.controlChange(128, 128);
shak.controlChange(11, 13);

4 => int MOD;
1::second => dur tempo;
0 => int beat;

string path, fileName;
me.dir(-1) => path;

"audio/PianoKoto_283-441.wav" => fileName;

path + fileName => fileName;
fileName => daidai.read;
0 => daidai.pos;

fun void playDaidai() {
	while (true) {
		0.8 => daidai.gain;
		0.1::second => now;
	}
}

fun void playBeat() {
	
	20::second => now;
	
	while (true) {
		if (beat % MOD == 0) {
			shak.controlChange(1071, 21);
//			<<<"MOD 0">>>;
		} else if (beat % MOD == 3 || beat % MOD == 1) {
			shak.controlChange(1071, 14);
//			<<<"MOD 1 3">>>;
		} else {
			shak.controlChange(1071, 5);
//			<<<"MOD 2">>>;
		}
		
		0.5 => shak.gain;
		1 => shak.noteOn;
		6::second => now;
		
		beat++;
//		<<< beat>>>;
	}
}

spork ~ playDaidai();
spork ~ playBeat();

while (true) {
	0.0035 => noise.gain;
	0.0035 => osc.gain;
	0.0035=> osc3.gain;
	0.0035 => osc4.gain;
	1::second => now;

}
