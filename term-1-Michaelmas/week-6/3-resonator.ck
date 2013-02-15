SinOsc lfo;
SinOsc tone;
HPF  rez;
Gain gain;
0.1 => gain.gain;

0.5 => lfo.freq;
500 => tone.freq;

function void pump()
{
	while(true)
	{
		(lfo.last() * 100) + 400 => tone.freq;
		0.0025 :: second => now;
	}
}

spork ~ pump();

lfo => blackhole;

tone => rez => gain => dac;
400 => rez.freq;
100 => rez.Q;



10 :: second => now;