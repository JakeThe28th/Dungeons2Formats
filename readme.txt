This program is for windows only currently.

Before you start the program, make sure you have extracted minecraft dungeons using QuickBMS
	(If you haven't done this, a good guide is here: https://docs.dungeonsworkshop.net/creatingmods/)
	
You'll also need to have minecraft java edition extracted.
	(If you havent done this, 
	

Copy the folder 'data' from
 '<where-you-extracted-dungeons>\Dungeons\Content\'
									to
 'C:\Users\<username>\AppData\Local\Dungeons_Objectgroup_Reader__GMS2_3_\'


Copy the folders 'textures', 'models', and 'blockstates' 
							from
 '<the minecraft version you extracted>\assets\minecraft\' 
							to 
 'C:\Users\<username>\AppData\Local\Dungeons_Objectgroup_Reader__GMS2_3_\data_mc'
 
 
Once you have those files in the correct places you can start the program.
Using the program itself is pretty simple. 
You can select a level in the top left corner, select an objectgroup in the top middle, and change the file type in the top right.
Once you're in the right level and objectgroup, you can select a tile (a piece of the level that minecraft dungeons puts together semi-randomly)

Then you can change the options by clicking on them, and export the tile by clicking the button that says "Convert!" (bottom left)

you'll be prompted to select a place to save the resulting file.

There's a progress bar, and once it's done exporting the file will be at the location you selected.

I reccomend that you copy the 'resourcepacks' folder 
from 'AppData\Local\Dungeons_Objectgroup_Reader__GMS2_3_\data\' and the 'textures' folder from before into that directory,
otherwise the textures won't load when imported into a 3d software like blender. 


BLOCK FILTERS

The converter reads block filters to determine what blocks are.


What block filter a level uses is determined by what resource pack the level uses.
Usually this matches with the level name, for example squidcoast, but sometimes it doesn't for example, redstone mines is mooncorecaverns.

Filters are stored in 'AppData\Local\Dungeons_Objectgroup_Reader__GMS2_3_\filters\<resourcepack_name>\<resourcepack_name>.json'.
They're formatted like this:

{
	"id,state,java_id[java_state=value,java_state=value,etc]"
}

The way dungeons levels are stored is that there's a base64 encoded zlib compressed stream of bytes, 
	the first 2/3 having each byte being a number representing a block, and the second 1/3 being half bytes, each half byte representing the block's state.
	This means that each block id can be a number between 0 and 255, and each block state can be a number between 0 and 15.
	I don't know what each ID is, but using trial and error we can make block filters, and figure out what the IDs are.
	
	
Here's a really small sample of a block filter.

{

  "38,0;dungeonmaster:LEVELNAME/flower_rose",
  "38,0;dungeonmaster:LEVELNAME/flower_oxeye_daisy",
  "31,2;dungeonmaster:LEVELNAME/fern",

  "-81,2;minecraft:tall_grass[half=lower]",
  "-81,3;minecraft:large_fern[half=lower]",
  "-81,10;minecraft:tall_grass[half=upper]",

}

dungeonmaster:LEVELNAME/<block_name> is a remnant from the original filters. 
Tastac, IP, and Ocelot made them for the dungeonmaster mod, which allows importing dungeons tiles into minecraft using custom blocks.
I would change the program to accept 'dungeons:block_name' instead, but probably not soon.

Basically it marks if a block is custom to dungeons, or should use textures from the dungeons directory and have a dynamically built model.
For example, in the game there's a block with a unique texture. In the resource pack's blocks file, it's called skull_path, so, if you wanted
to put that block in the filter, you'd do dungeonmaster:LEVELNAME/skull_path. I usually find these block names by checking the resource pack's 
block textures directory, finding the texture that looks closest to it, and then searching that texture name in the resource pack's blocks file.
If i don't find anything, i just put in the texture's name, and i let my converter attempt to build it based on that alone.

My converter builds models based on the block's name and states, so if it's called skull_path, it will use a path model, stone_slab, slab model, 
sandstone[type=top] would use a slab model, because only slabs use that type state.

Also, in the log file, it will note any block ID/state pairs that arent in the filter, so it's easier to figure out missing ones and fill them in.

NOTE: What may seem like a missing block in the exported .obj file may just be a non-fullblock, or a transparent block, that i havent coded in as transparent yet.
So check to make sure the block next to a missing block isn't just something like an end rod or a stair or glass.
If you turn off face culling it might solve this problem, and if you turn off full block culling it will solve this issue, but it will be a bit laggy.


if you need any help with this or my writing is confusing, ping me on discord (Jake_28#2672)