Shall We Play A Game
====================

Slides: https://www.slideshare.net/sghctoma/shall-we-play-a-game-51422285
Demo videos: https://www.youtube.com/playlist?list=PLO0QV3AGuqc9aIOxCVR7NEr89lUuSBSQv
Talk: https://www.youtube.com/watch?v=XxyRDkmNMHg


cfp_application.txt
-------------------

Before I submitted my CFP to DEFCON, I was desperately searching for accepted
CFPs from the past, without much success. I was curious about how much detail
people put in their CFP, how they organize their stuff, etc. It would've been a
huge help, if I could see some example, and this is why I've decided to make
mine public - maybe someday, somewhere it will be useful for somebody :)

demo1_crysis2/HackThePlanet
---------------------------

A Crysis 2 mod that contains one level (TheBigRedButton) with a big red button
that launches a program from a remote share when pressed. The "HackThePlanet"
folder should be placed to "<Crysis 2 folder>\Mods\". The actual code is in the
"HackThePlanet\GameCrysis2\Scripts\Entities\Button.lua" file.

demo1_crysis2/AlterCalculator 
-----------------------------

A simple .NET non-functional Calculator-ish thingy I started from a remote share
during my demo (popping calc.exe every time is boring...)

demo2_dota2/barebones
---------------------

A Dota 2 mod that decodes a minimal application that starts Calculator (calc.exe
itself is too large for this, having a nearly 1MB size) from a Base64-encoded
string variable, and replaces the original "dota.exe" with it. The "barebones"
folder should be placed to "<Dota 2 folder>\dota_ugc\content\dota_addons". The
actual exploit code starts at the 335th line of
"barebones\scripts\vscripts\barebones.lua"

demo3_dcsworld/loadlib_poc.miz
------------------------------

A DCS World mission that puts you into the cockpit of a TF-51D, and loads a DLL
from the following Samba share: "\\evilhaxor\a\DangerZone.dll" when you finally
crash :) The ".miz" file should be placed to "%userprofile%\Saved
Games\DCS\Missions". The ".miz" is a simple Zip archive, and the actual code can
be found at the 7th line of the file named "mission" in this archive.

demo3_dcsworld/DangerZoneDll
----------------------------

The DLL that got loaded when I crashed my plane in DCS.

demo5_gmod/test 
---------------

The Garry's Mod mod I've used to demonstrate the HTTPRequest abuse in the game.
There are 3 console commands that are accessible only to superadministrators:

 - hck_scanplayers: Scans every player's home network for HTTP servers. It gives
   back a list of live HTTP servers, their response, and the ID of the player
   whose network the server was found on.  Currently i scans only 192.168.0/24
   and 192.168.1.0/24 subnets.
 - hck_bruteforce: tries to guess HTTP Basic Authentication passwords. Requires
   victim player ID and HTTP server URL.
 - hck_getimage: Downloads an image from a specified URL, with the specified
   credentials and displays it in-game. Requires victim player ID, image URL and
   credentials.

demo6_logitech/demo6_logitech_poc.xml
-------------------------------------

The Logitech Gaming Software profile for the Logitech G402 mouse that contains
the Lua exploit.

demo6_logitech/redis_exploits 
-----------------------------

The Redis exploits I mentioned during my talk. These are not working with
current Redis versions, the vulnerability was disclosed by Ben Murphy the same
time I was doing my finishing touches on these exploits, and it is now fixed.

