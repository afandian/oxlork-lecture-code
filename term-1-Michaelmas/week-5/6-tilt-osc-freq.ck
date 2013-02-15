// Alter the frequency of the oscillator by the tilt sensor.

Hid humanInterfaceDevice;
HidMsg message;

TriOsc osc;
osc => dac;

if( !humanInterfaceDevice.openTiltSensor() )
{
    <<< "tilt sensor unavailable", "" >>>;
    me.exit();
}

while( true )
{
    humanInterfaceDevice.read(Hid.ACCELEROMETER, 0, message);
    <<< "acc x:", message.x, "acc y:", message.y>>>;
    
    (message.x / 2) + 400 => osc.freq;
    .0025::second => now;
}
