// Four different waves. Sine, Triangle, Square, Sawtooth.

SinOsc sine;
TriOsc triangle;
SqrOsc square;
SawOsc sawtooth;

// Connect Sine to DAC.
sine => dac;

// Wait 2 seconds.
2::second => now;

// Disconnect Sine from DAC.
sine !=> dac;

// Wait 2 seconds, then the same with the others.
2::second => now;

triangle => dac;
2::second => now;
triangle !=> dac;

2::second => now;

square => dac;
2::second => now;
square !=> dac;

2::second => now;

sawtooth => dac;
2::second => now;
sawtooth !=> dac;
