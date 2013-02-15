// A low-frequency oscillator modulating the 
// amplitude of a 'normal' frequency oscillator.

SinOsc osc;
osc => dac;
400 => osc.freq;

SinOsc lfo;
0.25 => lfo.freq;
lfo => blackhole;

float theValue;
while (true)
{
	lfo.last() => theValue;

	(theValue + 1) / 2 => theValue;
	
	theValue => osc.gain;
	
	0.001 :: second => now;
}


10 :: second => now;