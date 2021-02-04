This program is for windows only currently.

----

Before you start the program, make sure you have extracted minecraft dungeons using QuickBMS

(If you haven't done this, a good guide is here: https://docs.dungeonsworkshop.net/creatingmods/)
	
Copy the folder 'data' from

	'<where-you-extracted-dungeons>\Dungeons\Content\'
To:

	'<Where you unzipped the program>\'
	
(The path to the lovika folder would be '<program>\data\lovika' if you did it right)
	
----
	
You'll also need to have minecraft java edition extracted.
	
If you havent done this, here's a short guide: 
go to your .minecraft folder, go to versions, go to the version you want to extract, 
and use 7zip or another file extraction program to unzip the .jar file.
	


Copy the folders 'textures', 'models', and 'blockstates' 
from

	'<the minecraft version you extracted>\assets\minecraft\' 
to 

	'<Where you unzipped the program>\data_mc\'
 
(The path to the models folder would be '<program>\data_mc\models' if you did it right)
 
----
 
Once you have those files in the correct places you can start the program.
Using the program itself is pretty simple. 

You can select a level in the top left corner, select an objectgroup in the top middle, and change the file type in the top right.
Once you're in the right level and objectgroup, you can select a tile (a piece of the level that minecraft dungeons puts together semi-randomly)

Then you can change the options by clicking on them, and export the tile by clicking the button that says "Convert!" (bottom left)

you'll be prompted to select a place to save the resulting file.

There's a progress bar, and once it's done exporting the file will be at the location you selected.

I reccomend that you copy the 'resourcepacks' folder 
from 

	'<Where you unzipped the program>\data\'
into the exported file's directory, otherwise the textures won't load when imported into a 3d software like blender. 

----

This program uses blockshapes to determine block models, but since i started on other projects i kind of got lazy and didn't add most of them..
To get blockshape names, just search up something along the lines of minecraft bedrock blockshape names, and to add them yourself, just:

	A: Go to '<Where you unzipped the program>', and modify templates .zip, blockshapes are in the blockshapes folder
This will only work if you havent opened the program or cleared the program's directory in appdata\local,

	B: Go to 'AppData\Local\Dungeons_Objectgroup_Reader__GMS2_3_\templates\blockshapes' and copy your blockshapes to there.

Blockshapes in this program are formatted like minecraft java json models, with some replaceable text in them

basic.json (Blockshape i use when there isn't a blockshape specified, just a cube):

	{
	"parent": "minecraft:block/cube",
	"textures": {
		"north": "dungeons:%pack%/%north%",
		"south": "dungeons:%pack%/%south%",
		"east": "dungeons:%pack%/%east%",
		"west": "dungeons:%pack%/%west%",
		"up": "dungeons:%pack%/%up%",
		"down": "dungeons:%pack%/%down%"
	}
	}
This one is parented but they can have element data in them. 
%pack% is the pack name of the level that's being exported, but that's dealt with in the program so you dont have to worry abt it.

north, south, east, west, up, and down, are just the corresponding textures for each face. If you come across a model which needs a "side" texture, just use north.

----

if you need any help with the program, ping me on discord (Jake_28#2672)