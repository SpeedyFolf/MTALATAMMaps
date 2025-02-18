# GTA Speedrun LATAM Racing Maps

This repository contains all the maps used on the *MTA:SA* server **[GTA Speedrun LATAM Racing](https://mta.gtaspeedrun.lat)**. Here you will find a collection of maps organized into different categories according to their origin and game type.

## Repository Structure
The repository is divided into two main folders:

### [**[Robot]**](https://gitlab.com/The123robot/robot-mta-server)
This folder contains the maps coming from the **Robot** server. These maps were not originally created for GTA Speedrun Latam Racing, but are available for use on the server.

### **[LATAM]**
This folder contains **original maps created exclusively for GTA Speedrun LATAM Racing**. If you want to upload a new map, **you must place it in this folder** following the established rules and requirements.

---

## Basic requirements for uploading a map
In order for your map to be accepted by the server, you must meet the following minimum requirements:

1. **Racetype tag in meta.xml:** You must include the appropriate tag in the `meta.xml` file.
2. **Proper folder name:** The map folder name must follow established conventions.

Make sure to manually check that everything in the `meta.xml` file is correct before submitting your map. Note that the *MTA:SA* map editor tends to randomly delete data from the `meta.xml`, so be on the lookout for missing data.

If all of this seems complicated, you can leave a note with your submission and someone on the team will adjust it for you.

## Subfolder
Place your map in the **[LATAM]** folder, inside one of these subfolders:
* **[R]** -> Race: Point-to-point racing.
* **[SR]** -> Speedrun: Race based on a single player mission or speedrun route. Useful for practicing, discovering new routes, or enjoying the single player campaign with friends or strangers.
* **[DD]** -> Destruction Derby: Eliminate other players and try to be the last one standing!
* **[TW]** -> Teamwork: Work as a team with a randomly selected group to try to be the first team to complete a circuit. Some team members will need to help other teammates so the team can complete the course.
* **[MG]** -> Minigame: Compete against other players in a specific task on the map to win. The dynamics of the minigame will be explained to you when you play it.
* **[F]** -> Footrace: Races that are fully or partially on-foot (beta).
* **[RANDOM]** -> Randomizer: Races with some random factor, such as random vehicles, random handling, etc.

## Racetype tag
Maps require information within the meta.xml for the server to get some custom information.

Previously, map tags (*R/DD/TW/MG/SR*) were included directly in the map name. Now, please include them as a separate attribute, like this:
```xml
<info gamemodes="race" type="map" name="Name" author="You" version="1.0" racetype="DD"></info>
```

This will help to correctly display the map type on the server and on the website for searching maps by type.

## Folder name
Each map has a folder name that may or may not match the map name defined in the meta.xml. To avoid folder chaos, make sure they do match. Look at the other maps and follow the format. For more details, read this:
* The map folder must use **PascalCase**.
* Only use letters A-Z, a-z and digits 0-9. Remove punctuation and accent marks. Use the letter Q to represent question marks.
* Match the actual name of the map.
* Dashes can be used to separate series (e.g. Infernus Showdown/NC202154) or map numbers (for classic maps from the 2005-2008 archive whose original names have been lost) from the map title.

## Acknowledgements
We would like to thank all the map creators who have contributed to the growth of the **GTA Speedrun LATAM Racing** server.

- The **Robot** community for allowing us to use their maps and enriching the server experience.
- All the **GTA Speedrun LATAM** map creators who have designed original content for this server, helping to expand the variety and fun within the game.
