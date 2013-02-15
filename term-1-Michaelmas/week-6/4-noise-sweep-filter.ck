SinOsc lfo;
Noise noise;
BPF filter;

0.5 => lfo.freq;
0.05 => filter.Q;

function void pump()
{
	while(true)
	{
		(lfo.last() * 400) + 400 => filter.freq;
		0.0025 :: second => now;
	}
}

spork ~ pump();

lfo => blackhole;

noise => filter => dac;

10 :: second => now;