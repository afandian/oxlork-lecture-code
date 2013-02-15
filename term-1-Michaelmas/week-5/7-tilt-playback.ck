// Use X and Y tilt sensor to alter loop length and playback position
// of recording.

Hid humanInterfaceDevice;
HidMsg message;

if( !humanInterfaceDevice.openTiltSensor() )
{
    <<< "tilt sensor unavailable", "" >>>;
    me.exit();
}

int start;
dur length;

string filename;
me.sourceDir() + "/gliss.wav" => filename;

SndBuf buf;
JCRev reverb;
buf => reverb => dac;
filename => buf.read;

function void pump()
{
	while( true )
	{
		humanInterfaceDevice.read(Hid.ACCELEROMETER, 0, message);
		
		(message.x + 300) * 200 => start;
		(message.y / 4 + 300) :: ms => length;
		
		.025::second => now;
	}
}

spork ~ pump();

function void loopSound()
{
	while(true)
	{
		start => buf.pos;
		
		length => now;
	}
}

loopSound();