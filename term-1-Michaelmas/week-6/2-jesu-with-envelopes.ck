Hid humanInterfaceDevice;
HidMsg message;

if(!humanInterfaceDevice.openKeyboard(0)) me.exit();

int pitches[];
SinOsc oscs[5];

oscs[0] => dac;
oscs[1] => dac;
oscs[2] => dac;
oscs[3] => dac;
oscs[4] => dac;



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

[G,A, B,d,c, c,e,d,d,g,fs, g,d,B, G,A,B,c,d,e, d,c,B, A,B,G,Fs,G,A, D,Fs,A, c,B,A,B,G,A, B,d,c, c,e,d, d,g,fs, g,d,B, G,A,B, A,d,c, B,A,G, D,G,Fs, G,B,d, g,d,B, G] @=> pitches;

function void playFrequency(float frequency)
{
	frequency / 4 => oscs[0].freq;
	frequency / 2 => oscs[1].freq;
	frequency * 1 => oscs[2].freq;
	frequency * 2 => oscs[3].freq;
	frequency * 4 => oscs[4].freq;

	for (0 => float x; x <= 1; x + 0.1 => x)
	{
		x => dac.gain;
		
		0.001 :: second => now;
	}

	0.25 :: second => now;

	for (1 => float x; x >= 0; x - 0.005 => x)
	{
		x => dac.gain;
		
		0.001 :: second => now;
	}


}

function void keys()
{
	// infinite event loop
	while(true)
	{
		humanInterfaceDevice => now;
		while( humanInterfaceDevice.recv(message))
		{
			if( message.isButtonDown() )
			{
				if (message.which == 20)
				{
					1.0 => oscs[0].gain;
				}
				if (message.which == 4)
				{
					0.0 => oscs[0].gain;
				}

				if (message.which == 26)
				{
					1.0 => oscs[1].gain;
				}
				if (message.which == 22)
				{
					0.0 => oscs[1].gain;
				}

				if (message.which == 8)
				{
					1.0 => oscs[2].gain;
				}
				if (message.which == 7)
				{
					0.0 => oscs[2].gain;
				}

				if (message.which == 21)
				{
					1.0 => oscs[3].gain;
				}
				if (message.which == 9)
				{
					0.0 => oscs[3].gain;
				}

				if (message.which == 23)
				{
					1.0 => oscs[4].gain;
				}
				if (message.which == 10)
				{
					0.0 => oscs[4].gain;
				}
				
			}
		}
	}
}

spork ~ keys();

int length;
pitches.size() => length;
int i;
for (0 => i; i < length; i++)
{
	float frequency;
	Std.mtof(pitches[i]) => frequency;
	
	playFrequency(frequency);
}



