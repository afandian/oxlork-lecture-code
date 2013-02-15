// Store pitch names as MIDI pitches.
// An array with a list of these MIDI pitches as the tune.
// A for-loop to loop over the array and play the notes.

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

// A long array of MIDI pitches.
[G,A, B,d,c, c,e,d,d,g,fs, g,d,B, G,A,B,c,d,e, d,c,B, 
A,B,G,Fs,G,A, D,Fs,A, c,B,A,B,G,A, B,d,c, c,e,d, d,g,fs, 
g,d,B, G,A,B, A,d,c, B,A,G, D,G,Fs, G,B,d, g,d,B, G] @=> pitches;

// A for loop to loop over each element in the array.
int length;
pitches.size() => length;
int i;
for (0 => i; i < length; i+1 => i)
{
    // Calculate the MIDI pitch, assign it to the oscillator's frequency.
	Std.mtof(pitches[i]) => osc.freq;
    
    // Wait quater of a second before continuing.
	0.25 :: second => now;
}



