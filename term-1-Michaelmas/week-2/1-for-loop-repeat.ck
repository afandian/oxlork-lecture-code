// Wrap the tune in a 'for loop' to repeat it.
// The for loop runs twice.
// Equivalent of a repeat bar.

TriOsc myOscillator;

myOscillator => dac;

293 => int d;
329 => int e;
369 => int fs;
391 => int g;
440 => int a;

dur quaver;
1::minute / 200 => quaver;

int i;
for (0 => i; i < 2; i + 1 => i)
{
	d => myOscillator.freq;
	quaver => now;
	e => myOscillator.freq;
	quaver => now;
	fs => myOscillator.freq;
	quaver => now;
	g => myOscillator.freq;
	quaver => now;
	a => myOscillator.freq;
	quaver * 2 => now;
}

