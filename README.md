# EON Class Addition Mod
 Mod of Etrian Odyssey Nexus to add the Buccaneer and Alchemist classes to the game. Also adds a repeatable mission to fight Ren and Tlachtga.


Notes:

- Vampire portraits are added along with the Alchemist class. No need to unlock Vampires to get access to the portraits.
- When selecting Change Look the Vampire preview will show instead of the Buccaneer preview. Alchemist shows Protector 1 Portrait. Portraits are the same as making the class though.
- The "B" and "A" from Buccaneer and Alchemist repsectively are not shown on the equipment class list.	
- I've added a debug/cheat quest to give out cap exp to speed up the leveling a new Alchemist if you do not want to raise one or play a new game. To access it go to luma\titles\00040000001d4e00\romfs\Event and delete the "quest_table.tbl" file and rename "quest_tableCHEATQUEST.tbl" to "quest_table.tbl". (00040000001d5200 for the EU version) Once you accept the quest you just need to report it and it will give you the maximum possible exp the game allows(you need to do the quest twice to get to level 130).
- Buccaneer and Alchemist have the wrong descriptions during class creation.
- Ren and Tlachtga are recommened to be fought during postgame.
	
Buccaneer Skill Data: https://docs.google.com/document/d/1r_QC7Cjgy-1Vhi4Cn5eF2DlWF7pKMtsODpLsiGD8hvA/edit?usp=sharing

Alchemist Skill Data: https://docs.google.com/document/d/1KRdug1fNAuGYaRrIGNF4Kvy9_pQfHH7FELL4xtz4uxU/edit?usp=sharing
	
	
v1.0

- Fixed Force Breaks from doing chip damage
- Fixed Chasers to properly inherit elements. Eg Fire-slash chaser will now follow up with a Fire+Cut+Weapon Element instead of just Weapon Element. This also makes Vulcan stance increase chaser damage.
- Adjusted the stat growth for Buccaneers. Before their early level stats grew much faster than other classes.


v1.1

- Fixed a bug involving Dirty Fighting procing on normal attacks.
- Buccaneer's Rapier skills now use the AGL stat for damage.
- Buccaneer's Gun skills now target the enemy's AGL stat.(Formula is VIT+AGL)
- Hanging lowers their AGL defense(Gun skills will do more damage) for 1 turn
- Quick Draw increases the user's AGL for 1 turn(Rapier Skills will do more damage)
- Pincushion now uses the user's AGL for offense and the enemy's AGL for their defensive stat.
- Fixed a bug where Bullet Storm wouldn't be able to petrify the enemy.
- Fixed the display text of Dirty fighting proc.


v1.2

- Fixed a bug where Quick Draw buff was raising the damage of all damage sources instead of just rapier skills/Pincushion.
- Bullet Storm actually petrifies instead of paralyzing the enemy.
- Fixed a bug where Dirty fighting would have a guaranteed proc rate if equipping a gun but no rapier.
- Fixed a bug where using Buccaneer Force Boost could cause a crash while playing on a 3DS.


v1.3
- Fixed a data error on Buccaneer's Enhanced chase where level 4 would only add 3 Chases and not 9.
- Fixed a bug where Ronins would not crit when using the correct skills during the correct stance.
- Added subclass text in the status screen for Buccaneer and Alchemist.
- Added the Alchemist class.
- Buccaneer's Ultimate armour Calico Sailor now has a description. Available from Ketos's Conditional.
- Alchemist's Ultimate armour Oroborus Robe available from Storm Emperor's Conditional.

v1.3.1
- Fixed Revenge Curse not scaling with HP loss.
- Fixed a bug with being unable to use Riot Formula if you did not have the max TP it costed.

v1.3.2
- Fixed crash when opening the skill menu when equipping a weapon skill.

v1.3.3
- Fixed crash when opening the skill menu when equipping a weapon skill while Fire Palm is active.
- Fixed a bug where Venom Formula's Poison chance stack was not adding.

v1.3.4
- Fixed crash when opening the skill menu when equipping two or more weapon skills.

v1.3.5
- Fixed a crash involving Links when used with a party member who had Double Chase learned.
- Fixed enemy buffs displaying the wrong name.

v1.3.6
- Changed how file loading works so there's no softlock when attempting to load a non existing file.