SinOsc osc => JCRev rev =>dac;
SinOsc osc2 => JCRev rev2 =>dac;
SinOsc osc3 => JCRev rev3 =>dac;
SinOsc osc4 => JCRev rev4 =>dac;
Noise noise =>dac;

SndBuf zakuro => dac;

Shakers shak => JCRev rev5 => dac;

string path, fileName;
me.dir(-1) => path;

"audio/PianoKoto_0-283.wav" => fileName;

path + fileName => fileName;
fileName => zakuro.read;
6000000 => zakuro.pos;
//0 => zakuro.pos;

//<<< "path", me.dir() >>>;
//<<< "fileName", fileName >>>;

0 => int flag;

155 => float highest;
80 => float lowest;
lowest => float frq2;

0.5 => float ratio;
0.02 => osc.gain;          
0.035 => osc2.gain;  
0.02 => osc3.gain;          
0.035 => osc4.gain;
0.003 => noise.gain;
          
fun void playZakuro() {
	while (true) {
		0.95 => zakuro.gain;
		0.1::second => now;
	}
}

fun void bell() {
	33::second => now;
	
	while (true) {
		Math.random2(15, 35) => int timing;
		Math.random2(1000, 2000) => int rf;
//		<<< "timing", timing >>>;
//		<<< "rf", rf >>>;
		1 => shak.noteOn;
		shak.controlChange(1071, 22);
		shak.controlChange(1, rf);
		shak.controlChange(2, 2500);
		shak.controlChange(4, 32);
		shak.controlChange(128, 316);
		shak.controlChange(11, 500);

		0.6 => shak.gain;
		timing::second => now;
	}
}

spork ~ playZakuro();
spork ~ bell();

while (true) {
	if (flag == 0 && frq2 > lowest) {
		frq2 - ratio => frq2;
	} else if (frq2 <= lowest) {
		frq2 + ratio => frq2;
		1 => flag;
	} if (flag == 1 && frq2 < highest) {
		frq2 + ratio => frq2;
	}if (frq2 >= highest) {
		0 => flag;
		frq2 - ratio => frq2;
	}
	osc.freq(96);
	osc3.freq(48);
	osc4.freq(147);
	osc2.freq(frq2);
//    <<< "frq2 ", frq2 >>>;
    0.3::second => now;
}