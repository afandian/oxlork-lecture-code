SqrOsc lfo;

lfo => blackhole;

1 => lfo.freq;

SinOsc osc;

1000 => osc.freq;

JCRev reverb;

osc => reverb => dac;

0.5 => reverb.mix;

function void pump()
{
	while(true)
	{
		lfo.last() / 2 + 0.5 => osc.gain;
		0.0025 :: second => now;
	}
}

spork ~ pump();

10 :: second =>now;