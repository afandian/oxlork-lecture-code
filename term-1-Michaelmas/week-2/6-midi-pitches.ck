// Looking up frequencies from MIDI pitches and using them in an oscillator.

TriOsc myOscillator;
myOscillator => dac;

// Store the MIDI pitch values not the frequencies.
62 => int d;
64 => int e;
66 => int fs;
67 => int g;
69 => int a;

dur quaver;
1::minute / 200 => quaver;

// Calculate the frequency from the MIDI pitch and use that frequency.
Std.mtof(d) => myOscillator.freq;
quaver => now;
Std.mtof(e) => myOscillator.freq;
quaver => now;
Std.mtof(fs) => myOscillator.freq;
quaver => now;
Std.mtof(g) => myOscillator.freq;
quaver => now;
Std.mtof(a) => myOscillator.freq;
quaver * 2 => now;
