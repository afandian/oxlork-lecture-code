// Now we have different tonal modes from number keys.
// 1 - chromatic
// 2 - whole tone
// 3 - diatnoic

// Also 2 change modes:
// 4 - instant
// 5 - portamento

Hid hid;
HidMsg hidMsg;
if (!hid.openKeyboard(0))
{
    me.exit();
}

TriOsc osc;
osc => dac;

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

0 => CHANGE_INSTANT;
1 => CHANGE_PORTAMENTO;

int changeMode;
CHANGE_INSTANT => changeMode;

[0, 2, 4, 5, 7, 9, 11] @=> int DIATONIC_DEGREES[];

int octave;
0 => octave;

int degree;

float destinationPitch;
float currentPitch;

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
        
        if (changeMode == CHANGE_INSTANT)
        {
            destinationPitch => currentPitch;
        }
        if (changeMode == CHANGE_PORTAMENTO)
        {
            ((destinationPitch - currentPitch) / 10) + currentPitch => currentPitch; 
        }
        
        // Snap if close.
        if(math.fabs(currentPitch - destinationPitch) < 5)
        {
            destinationPitch => currentPitch;
        }
        
        Std.mtof(currentPitch) => osc.freq;
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
                CHANGE_INSTANT => changeMode;
            }
            else if (hidMsg.which == 34)
            {
                // 5
                CHANGE_PORTAMENTO => changeMode;
            }
            else 
            {
                keyboardToDegree(hidMsg.which) => degree;
                degreeToPitch(degree, octave, keyboardMode) => destinationPitch;
            }  
            
            <<<  "KEYBOARD MODE", keyboardMode >>>;
        }
    }
}