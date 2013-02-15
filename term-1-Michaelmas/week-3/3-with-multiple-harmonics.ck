// Now we have an array of SinOscs. 
// Each one is given a mulitple of the frequency, i.e. harmonics.
// Gives a pipe-organ sound.

int pitches[];
SinOsc oscs[5];


// Try commenting and uncommenting to push organ stops in or out.
oscs[0] => dac;
oscs[1] => dac;
//oscs[2] => dac;
oscs[3] => dac;
//oscs[4] => dac;


int D, E, F, Fs, G, A, B, c, d, e, f, fs, g, a, b;

62 => D;
64 => E;
65 => F;
66 => Fs;
67 => G;
69 => A;
71 => B;
72 => c;
74 => d;
76 => e;
77 => f;
78 => fs;
79 => g;
81 => a;
83 => b;

[60, 61, 62] @=> pitches;

[G,A, B,d,c, c,e,d,d,g,fs, g,d,B, G,A,B,c,d,e, 
d,c,B, A,B,G,Fs,G,A, D,Fs,A, c,B,A,B,G,A, 
B,d,c, c,e,d, d,g,fs, g,d,B, G,A,B, A,d,c,
 B,A,G, D,G,Fs, G,B,d, g,d,B, G] @=> pitches;

function void assignFrequency(float frequency)
{
	frequency / 4 => oscs[0].freq;
	frequency / 2 => oscs[1].freq;
	frequency * 1 => oscs[2].freq;
	frequency * 2 => oscs[3].freq;
	frequency * 4 => oscs[4].freq;
}

int length;
pitches.size() => length;
int i;
for (0 => i; i < length; i++)
{
	float frequency;
	Std.mtof(pitches[i]) => frequency;
	
	assignFrequency(frequency);
	
	0.25 :: second => now;
	
	0 => dac.gain;
	0.025 :: second => now;
	1 => dac.gain;
}



