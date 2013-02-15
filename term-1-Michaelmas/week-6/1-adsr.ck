TriOsc osc;

osc => dac;


for (0 => float x; x <= 1; x + 0.025 => x)
{
	x => osc.gain;
	
	0.001 :: second => now;
}


0.5 :: second => now;


for (1 => float x; x >= 0; x - 0.005 => x)
{
	x => osc.gain;
	
	0.001 :: second => now;
}
