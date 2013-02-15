// Print out what the tilt sensors tell us.

Hid humanInterfaceDevice;
HidMsg message;

if( !humanInterfaceDevice.openTiltSensor() )
{
    <<< "tilt sensor unavailable", "" >>>;
    me.exit();
}

while( true )
{
    humanInterfaceDevice.read(Hid.ACCELEROMETER, 0, message);
    <<< "acc x:", message.x, "acc y:", message.y>>>;
    .25::second => now;
}
