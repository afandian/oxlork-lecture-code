TriOsc osc;
osc => dac;

int pitches[];

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

[G,A, B,d,c, c,e,d,d,g,fs, g,d,B, G,A,B,c,d,e, 
d,c,B, A,B,G,Fs,G,A, D,Fs,A, c,B,A,B,G,A, 
B,d,c, c,e,d, d,g,fs, g,d,B, G,A,B, A,d,c, 
B,A,G, D,G,Fs, G,B,d, g,d,B, G] @=> pitches;

int length;
pitches.size() => length;
int i;
for (0 => i; i < length; i++)
{
	Std.mtof(pitches[i]) => osc.freq;
	0.25 :: second => now;
	
    // Turn the gain down for a fraction of a second to get a break
    // between notes.
	0 => osc.gain;
	0.025 :: second => now;
	1 => osc.gain;
}



