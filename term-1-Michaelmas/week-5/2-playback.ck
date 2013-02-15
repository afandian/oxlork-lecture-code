// Load and play back a sample.
// Wait 10 seconds so we can hear it.
string filename;
me.sourceDir() + "/gliss.wav" => filename;

SndBuf buf => dac;
buf.read(filename);

10 :: second => now;