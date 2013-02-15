// Beginnings of the keyboard. Top row QWERTY etc for pitches.
// Tab and enter to shift octaves.

Hid hid;
HidMsg hidMsg;
if (!hid.openKeyboard(0))
{
    me.exit();
}

TriOsc osc;
osc => dac;

int octave;
0 => octave;

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

int degree;

while (true)
{   
    hid => now;
    while (hid.recv(hidMsg))
    {
        if(hidMsg.isButtonDown())
        {
            if (hidMsg.which == 43)
            {
                octave - 1 => octave;
            }    
            else if (hidMsg.which == 40)
            {
                octave + 1 => octave;                
            }
            else 
            {
                keyboardToDegree(hidMsg.which) => degree;
            }  
            
            Std.mtof(degree + 60 + (octave * 12)) => osc.freq;
        }
    }
}