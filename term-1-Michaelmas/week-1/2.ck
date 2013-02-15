// Package the tune into a function.
// Represent the frequencies with variables with useful names.
// Represent 'a quaver' with a variable.
// Run the function for different values of 'quaver'.

SinOsc myOscillator;

myOscillator => dac;

293 => int d;
329 => int e;
369 => int fs;
391 => int g;
440 => int a;

dur quaver;


function void bar1()
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


// Run bar 1 three times with different speed

1::minute / 120 => quaver;
bar1();
1::minute / 150 => quaver;
bar1();
1::minute / 200 => quaver;
bar1();