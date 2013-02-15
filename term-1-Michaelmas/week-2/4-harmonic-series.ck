// 20 SinOscs, to represent the harmonic series.
// Sounds musical.

SinOsc oscs[20];

for (0 => int x; x < oscs.size(); x++)
{    
    200 * x + 1 => oscs[x].freq;
    1.0 / (x + 1) => oscs[x].gain;
}

// One by one, connect them to the DAC.
for (0 => int x; x < oscs.size(); x++)
{
    1 :: second => now;
    oscs[x] => dac;
}

// Let it sink in before stopping.
5::second => now;