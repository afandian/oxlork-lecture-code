SinOsc lfo;
lfo => blackhole;

SqrOsc noise;

500 => noise.freq;

LPF filter;

0.2 => lfo.freq;

function void pump()
{
	while(true)
	{
		(lfo.last() * 1000) + 1500 => filter.freq;
		
		0.025 :: second => now;
	}
}

spork ~ pump();

1 => filter.Q;

noise => filter => dac;



10 :: second => now;
