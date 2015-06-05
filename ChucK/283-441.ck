SawOsc osc => JCRev rev0 =>dac;
SawOsc osc3 => JCRev rev3 =>dac;
SawOsc osc4 => JCRev rev4 =>dac;
SubNoise noise => ResonZ rz => dac;
Shakers shak => PRCRev rev  => dac;
SndBuf daidai => dac;

osc3.freq(87.3);
osc4.freq(55);

noise.rate(13);

shak.controlChange(1, 15);
shak.controlChange(2, 128);
shak.controlChange(4, 3);
shak.controlChange(128, 128);
shak.controlChange(11, 13);

rev.mix(0.4); 

4 => int MOD;
1::second => dur tempo;
0 => int beat;

1 => int freq;
0.0008 => float gn;
1 => int flagg;
1 => int flagf;
15 => int ratiof;
0.00005 => float ratiog;

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
	1 => shak.noteOff;
	
	20::second => now;
	
	while (true) {
		if (beat % MOD == 0) {
			shak.controlChange(1071, 21);
		} else if (beat % MOD == 3 || beat % MOD == 1) {
			shak.controlChange(1071, 14);
		} else {
			shak.controlChange(1071, 5);
		}
		
		0.5 => shak.gain;
		1 => shak.noteOn;
		6::second => now;
		
		beat++;
	}
}

spork ~ playDaidai();
spork ~ playBeat();

while (true) {
	0 => noise.gain;
	0.0008 => osc.gain;
	0.0008 => osc3.gain;
	0.0008 => osc4.gain;
	
	33::second => now;
	
	while (true) {
		if (flagg == 0 && gn > 0.0015) {
			gn - ratiog => gn;
		} else if (gn <= 0.0015) {
			gn + ratiog => gn;
			1 => flagg;
		} if (flagg == 1 && gn < 0.004) {
			gn + ratiog => gn;
		}if (gn >= 0.004) {
			0 => flagg;
			gn - ratiog => gn;
		}
	<<<gn>>>;
	
	    if (flagf == 0 && freq > 100) {
			freq - ratiof => freq;
		} else if (freq <= 100) {
			freq + ratiof => freq;
			1 => flagf;
		} if (flagf == 1 && freq < 1300) {
			freq + ratiof => freq;
		}if (freq >= 1300) {
			0 => flagf;
			freq - ratiof => freq;
		}
	<<<freq>>>;

        rz.freq(freq);

        0.015 => noise.gain;
		gn => osc.gain;
		gn=> osc3.gain;
		gn => osc4.gain;
		.4::second => now;
	}
}
