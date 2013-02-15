// An LFO to modulate the pan
// Another LFO to modulate the frequency. 

SinOsc osc;
osc => dac;
400 => osc.freq;

SinOsc lfo;
2.1 => lfo.freq;
lfo => blackhole;

SinOsc vib;
vib => blackhole;
3 => vib.freq;

int myFreq;
440 => myFreq;

float theValue;
while (true)
{
	lfo.last()  => dac.pan;
	
	(vib.last() * 10) + myFreq => osc.freq;
	
	0.001 :: second => now;
}


