// Print out what keys we're pressing.

Hid humanInterfaceDevice;
HidMsg message;

if(!humanInterfaceDevice.openKeyboard(0)) me.exit();

// infinite event loop
while(true)
{
    humanInterfaceDevice => now;
    while( humanInterfaceDevice.recv(message))
    {
        if( message.isButtonDown() )
        {
			<<< message.which >>>;
        }
    }
}
