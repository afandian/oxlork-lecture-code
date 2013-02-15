// Loads more!
// Now change modes:
// 4 - instant change
// 5 - portamento
// 6 - slow portamento

// And channels!
// 7 channel 1
// 8 channel 2
// 9 channel 3

// And we're using a sound sample!

Hid hid;
HidMsg hidMsg;
if (!hid.openKeyboard(0))
{
    me.exit();
}

string filename;
me.sourceDir() + "/piano.wav" => filename;

int NUM_CHANNELS;
3 => NUM_CHANNELS;


SndBuf buf[3];
LiSa sample[NUM_CHANNELS];



int j;
for (0 => j; j < NUM_CHANNELS; j + 1 => j)
{
    buf[j].read(filename);

    buf[j].samples()::samp => sample[j].duration;
    0 => buf[j].pos;
    
    for ( 0 => int i; i < buf[j].samples(); i++ )
    {
        sample[j].valueAt(buf[j].valueAt(i), i::samp);
    }
    
    sample[j] => dac;

    sample[j].play(1);
    0.5::second => sample[j].loopStart;
    0.6::second => sample[j].loopEnd;
    
    <<< "loop", j >>>;
}





int MODE_CHROMATIC;
int MODE_WHOLE_TONE;
int MODE_DIATONIC;

0 => MODE_CHROMATIC;
1 => MODE_WHOLE_TONE;
2 => MODE_DIATONIC;

int keyboardMode;
MODE_CHROMATIC => keyboardMode;

int CHANGE_INSTANT;
int CHANGE_PORTAMENTO;
int CHANGE_PORTAMENTO_SLOW;

0 => CHANGE_INSTANT;
1 => CHANGE_PORTAMENTO;
2 => CHANGE_PORTAMENTO_SLOW;

int changeMode[];
[CHANGE_INSTANT, CHANGE_PORTAMENTO, CHANGE_INSTANT] @=> changeMode;


[0, 2, 4, 5, 7, 9, 11] @=> int DIATONIC_DEGREES[];

int keyboardChannel;
0 => keyboardChannel;

int octave;
0 => octave;

int degree;

float destinationPitch[3];
float currentPitch[3];

function int keyboardToDegree(int keyCode)
{
    if (keyCode == 20) return 0;
    else if (keyCode == 26) return 1;    
    else if (keyCode == 8) return 2;    
    else if (keyCode == 21) return 3;    
    else if (keyCode == 23) return 4;    
    else if (keyCode == 28) return 5;    
    else if (keyCode == 24) return 6;    
    else if (keyCode == 12) return 7;    
    else if (keyCode == 18) return 8;    
    else if (keyCode == 19) return 9;    
    else if (keyCode == 47) return 10;    
    else if (keyCode == 48) return 11;    
    return -1;
} 

function float degreeToPitch(int theDegree, int theOctave, int theMode)
{
    if (theMode == MODE_CHROMATIC)
    {
        return (degree + 60.0 + (theOctave * 12));
    }
    else if (theMode == MODE_DIATONIC)
    {
        return DIATONIC_DEGREES[theDegree % 7] + 60.0 + (((theDegree / 7) + theOctave) * 12.0);
    }
    else if (theMode == MODE_WHOLE_TONE)
    {
       return((theDegree * 2.0) + 60.0 + (theOctave * 12));
    }
        
    return 0.0;
}

function void converge()
{
    while (1 == 1)
    {
        0.01 :: second => now;
        
        int i;
        for (0 => i; i < NUM_CHANNELS; i ++)
        {
            if (changeMode[i] == CHANGE_INSTANT)
            {
                destinationPitch[i] => currentPitch[i];
            }
            if (changeMode[i] == CHANGE_PORTAMENTO)
            {
                ((destinationPitch[i] - currentPitch[i]) / 20) + currentPitch[i] => currentPitch[i]; 
            }
            if (changeMode[i] == CHANGE_PORTAMENTO_SLOW)
            {
                ((destinationPitch[i] - currentPitch[i]) / 200) + currentPitch[i] => currentPitch[i]; 
            }
            // Snap if close.
            if(math.fabs(currentPitch[i] - destinationPitch[i]) < 0.5)
            {
                destinationPitch[i] => currentPitch[i];
            }

            // The frequency of the pitch, divided by Middle C to give
            // a ratio of middle C to the note, i.e. the amount by which
            // the sample should be multiplied to give the pitch we want.
            Std.mtof(currentPitch[i]) / 261 => sample[i].rate;
        }
    }
}

spork ~ converge();

while (true)
{   
    hid => now;
    while (hid.recv(hidMsg))
    {
        if(hidMsg.isButtonDown())
        {
            <<< hidMsg.which >>>;
            if (hidMsg.which == 43)
            {
                octave - 1 => octave;
            }    
            else if (hidMsg.which == 40)
            {
                octave + 1 => octave;                
            }
            else if (hidMsg.which == 30)
            {
                // 1
                MODE_CHROMATIC => keyboardMode;
            }
            else if (hidMsg.which == 31)
            {
                // 2
                MODE_WHOLE_TONE => keyboardMode;
            }
            else if (hidMsg.which == 32)
            {
                // 3
                MODE_DIATONIC => keyboardMode;
            }
            else if (hidMsg.which == 33)
            {
                // 4
                CHANGE_INSTANT => changeMode[keyboardChannel];
            }
            else if (hidMsg.which == 34)
            {
                // 5
                CHANGE_PORTAMENTO => changeMode[keyboardChannel];
            }
            else if (hidMsg.which == 35)
            {
                // 6
                CHANGE_PORTAMENTO_SLOW => changeMode[keyboardChannel];
            }
            else if (hidMsg.which == 36)
            {
                // 7
                0 => keyboardChannel;
            }
            else if (hidMsg.which == 37)
            {
                // 8
                1 => keyboardChannel;
            }
            else if (hidMsg.which == 38)
            {
                // 9
                2 => keyboardChannel;
            }
            else 
            {
                keyboardToDegree(hidMsg.which) => degree;
                
                if (degree >= 0 && degree <= 11)
                {
                    degreeToPitch(degree, octave, keyboardMode) => destinationPitch[keyboardChannel];
                }
            }  
            
            <<<  "KEYBOARD MODE", keyboardMode >>>;
        }
    }
}