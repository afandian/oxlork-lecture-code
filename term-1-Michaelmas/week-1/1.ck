// A short tune with a Sine Oscillator, giving frequencies.

SinOsc oscillator;

oscillator => dac;

293 => oscillator.freq;
0.25::second => now;

329 => oscillator.freq;
0.25::second => now;

369 => oscillator.freq;
0.25::second => now;

391 => oscillator.freq;
0.25::second => now;

440 => oscillator.freq;
0.5::second => now;

