// 100 Sine waves, at random frequences and amplitude.
// Sounds distinctly unmusical!

SinOsc oscs[100];

for (0 => int x; x < oscs.size(); x++)
{    
    Std.rand2f(100.0, 10000.0) => oscs[x].freq;
    Std.rand2f(0.0, 0.005) => oscs[x].gain;
}

for (0 => int x; x < oscs.size(); x++)
{
    0.1 :: second => now;
    oscs[x] => dac;
}


5::second => now;