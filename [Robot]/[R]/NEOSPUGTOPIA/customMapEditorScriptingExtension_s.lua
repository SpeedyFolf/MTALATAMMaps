-- FILE: customMapEditorScriptingExtension_s.lua
-- PURPOSE: Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION: 07/January/2025 , custom edit by LotsOfS
-- IMPORTANT: Check the resource 'editor_main' at https://github.com/mtasa-resources/ for updates

local resourceName = getResourceName(resource)
local usedLODModels = {}
local LOD_MAP_NEW = {}

-- Makes removeWorldObject map entries and LODs work
local function onResourceStartOrStop(startedResource)
	local startEvent = eventName == "onResourceStart"
	local removeObjects = getElementsByType("removeWorldObject", source)

	for removeID = 1, #removeObjects do
		local objectElement = removeObjects[removeID]
		local objectModel = getElementData(objectElement, "model")
		local objectLODModel = getElementData(objectElement, "lodModel")
		local posX = getElementData(objectElement, "posX")
		local posY = getElementData(objectElement, "posY")
		local posZ = getElementData(objectElement, "posZ")
		local objectInterior = getElementData(objectElement, "interior") or 0
		local objectRadius = getElementData(objectElement, "radius")

		if startEvent then
			removeWorldModel(objectModel, objectRadius, posX, posY, posZ, objectInterior)
			removeWorldModel(objectLODModel, objectRadius, posX, posY, posZ, objectInterior)
		else
			restoreWorldModel(objectModel, objectRadius, posX, posY, posZ, objectInterior)
			restoreWorldModel(objectLODModel, objectRadius, posX, posY, posZ, objectInterior)
		end
	end

	if startEvent then
		local useLODs = get(resourceName..".useLODs")

		if useLODs then
			local objectsTable = getElementsByType("object", source)

			for objectID = 1, #objectsTable do
				local objectElement = objectsTable[objectID]
				local objectModel = getElementModel(objectElement)
				local lodModel = LOD_MAP_NEW[objectModel]

				if lodModel then
					local objectX, objectY, objectZ = getElementPosition(objectElement)
					local objectRX, objectRY, objectRZ = getElementRotation(objectElement)
					local objectInterior = getElementInterior(objectElement)
					local objectDimension = getElementDimension(objectElement)
					local objectAlpha = getElementAlpha(objectElement)
					local objectScale = getObjectScale(objectElement)
					
					local lodObject = createObject(lodModel, objectX, objectY, objectZ, objectRX, objectRY, objectRZ, true)
					
					setElementInterior(lodObject, objectInterior)
					setElementDimension(lodObject, objectDimension)
					setElementAlpha(lodObject, objectAlpha)
					setObjectScale(lodObject, objectScale)

					setElementParent(lodObject, objectElement)
					setLowLODElement(objectElement, lodObject)

					usedLODModels[lodModel] = true
				end
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStartOrStop, false)
addEventHandler("onResourceStop", resourceRoot, onResourceStartOrStop, false)

-- MTA LOD Table [object] = [lodmodel] 
LOD_MAP_NEW = {
	[3977] = 4056, -- lariversec1_lan => lodlariversec1_lan (LAn)
	[11001] = 11033, -- mission_16_sfs => lod_sfs022 (SFSe)
	[5135] = 5196, -- brkwrhus02 => lodwrhus03 (LAs2)
	[3469] = 3523, -- vegenmotel1 => lodenmotel13 (vegasN)
	[6924] = 7211, -- vgnlowbuild21 => lodlowbuild21 (vegasN)
	[4885] = 5053, -- lastranentun4_las => lodtranentun4_las (LAs)
	[13059] = 13062, -- cefact03 => lodcefact03 (countrye)
	[6930] = 6938, -- vegasplant05 => lodasplant05 (vegasN)
	[6933] = 6941, -- vegasplant08 => lodasplant08 (vegasN)
	[11541] = 11579, -- dambit3 => des_damlodbit3 (countryN)
	[7191] = 7195, -- vegasnnewfence2b => lodasnnewfence2b (vegasN)
	[8489] = 8700, -- flamingo01_lvs => lodmingo01_lvs (vegasE)
	[8240] = 8241, -- vgssbighanger1 => lodsbighanger1 (vegasS)
	[3989] = 4137, -- bonaplazagr_lan => lodbonaplazagr_lan (LAn)
	[5668] = 5669, -- laebridgeb => lodlaebridgeb (LAe)
	[5420] = 5645, -- laestormdrain03 => lodlaestormdrain03 (LAe)
	[3866] = 3869, -- demolish1_sfxrf => loddemolish1_sfxrf (SFSe)
	[18245] = 18499, -- cuntwjunk02 => lodcrushers (countryS)
	[11326] = 11328, -- sfse_hublockup => lod_hublockup (SFSe)
	[12860] = 13192, -- sw_cont04 => sw_cont04_lod (countrye)
	[17500] = 17571, -- stormdrainlae2_05 => lodrdrai3a_lae2 (LAe2)
	[5174] = 5223, -- sanpedmexq4_las2 => lodpedmexq4_las2 (LAs2)
	[10828] = 10893, -- drydock1_sfse => loddock1_sfse (SFSe)
	[4156] = 4157, -- roads17_lan => lodroads17_lan (LAn)
	[9302] = 9371, -- sfn_town01 => lod_town01 (SFn)
	[10834] = 10899, -- navybase_03_sfse => lodybase_03_sfse (SFSe)
	[5183] = 5205, -- nwspltbild1_las2 => lodpltbild1_las2 (LAs2)
	[10846] = 10915, -- gen_whouse03_sfse => lod_whouse03_sfse (SFSe)
	[8553] = 8764, -- vgseland21_lvs => lodeland21_lvs (vegasE)
	[8555] = 8709, -- vgsecrthse => lodecrthse (vegasE)
	[3494] = 3495, -- luxorpillar04_lvs => lodorpillar04_lvs (vegasE)
	[4168] = 4169, -- roads23_lan => lodroads23_lan (LAn)
	[5189] = 5198, -- ctddwwnblk_las2 => loddwwnblk_las2 (LAs2)
	[7231] = 7267, -- clwnpocksgn_d => lodnpocksgn_d (vegasN)
	[10027] = 9939, -- bigwhiete_sfe => loda06 (SFe)
	[8314] = 8317, -- vgsselecfence17 => lodselecfence17 (vegasS)
	[16223] = 16729, -- s_bit_13 => lod_s_bit_20 (countn2)
	[3626] = 3770, -- dckwrkhut => lodwrkhut (LAs2)
	[3244] = 3338, -- pylon_big1_ => pylon_lodbig1_ (countn2)
	[12912] = 13053, -- sw_silo04 => lodsw_silo04 (countrye)
	[11131] = 10800, -- roadssfse78 => lodroadssfse78 (SFSe)
	[10625] = 10660, -- lowqueens2_sfs => lodqueens2_sfs (SFs)
	[10627] = 10667, -- queens_02_sfs => lodens_02_sfs (SFs)
	[10629] = 10673, -- queens_04_sfs => lodens_04_sfs (SFs)
	[10775] = 10796, -- bigfactory_sfse => lod_sfs080e (SFSe)
	[3887] = 3888, -- demolish4_sfxrf => loddemolish4_sfxrf (SFSe)
	[5720] = 5941, -- holbuild02_law => lodbuild02_law (LaWn)
	[7251] = 7259, -- vgnorthcoast05b => lodorthcoast05b (vegasN)
	[4193] = 4194, -- officeblok1_lan => lodofficeblok1_lan (LAn)
	[6234] = 6241, -- canal_floor2 => lodcanal_floor2 (LAw)
	[3636] = 3683, -- indust1las_las => lod_indust1las (countn2)
	[3637] = 3779, -- indust1las2_las => lodust1las2_las2 (LAs2)
	[5729] = 5946, -- melblok02_lawn => lodblok02_lawn (LaWn)
	[3256] = 3290, -- refchimny01 => lod_refchimny01 (countn2)
	[9900] = 9936, -- landshit_09_sfe => loda02 (SFe)
	[4203] = 4204, -- lariversec1b_lan => lodlariversec1b_lan (LAn)
	[8886] = 8962, -- vgsefrght04 => lodefrght04 (vegasE)
	[3258] = 3289, -- refthinchim1 => lod_refthinchim1 (countn2)
	[9910] = 9973, -- fishwarf01 => loda32 (SFe)
	[5737] = 5935, -- archshop07_law02 => lodhshop07_law02 (LaWn)
	[10936] = 11158, -- landbit04_sfs => lodndbit04_sfs (SFSe)
	[3643] = 3745, -- la_chem_piping => lodla_chem_piping (LAs2)
	[10430] = 10517, -- hashblock1_08_sfs => lod_sfs054 (SFs)
	[7273] = 7382, -- vgsn_frent_shps => lodn_frent_shps (vegasN)
	[9926] = 9944, -- ferryshops07 => loda12 (SFe)
	[5311] = 5319, -- las2lnew1_las2 => lod2lnew1_las2 (LAs2)
	[10950] = 11018, -- shoppie2_sfs => lod_sfs004 (SFSe)
	[11462] = 11624, -- des_railbridge1 => des_rail_lod (countryN)
	[4729] = 4754, -- billbrdlan2_01 => lodbillbrdlan2_01 (LAn2)
	[10195] = 10240, -- hotelbits_sfe02 => lodelbits_sfe02 (SFe)
	[4085] = 4098, -- supports01_lan => lodsupports01_lan (LAn)
	[3269] = 3369, -- bonyrd_block1_ => lod_bnyd_blk1_ (countn2)
	[10974] = 11402, -- mall_01_sfs => lod_sfs014roof (SFSe)
	[3270] = 3368, -- bonyrd_block2_ => lod_bnyd_blk2_ (countn2)
	[9958] = 10285, -- submarr_sfe => lodmarr_sfe (SFe)
	[7291] = 6943, -- vegasplant10 => lodasplant10 (vegasN)
	[7037] = 7215, -- vgnwalburger1 => lodwalburger1 (vegasN)
	[7548] = 7774, -- vegaswedge17 => lodaswedge17 (vegasW)
	[8436] = 8922, -- shop12_lvs => lodp12_lvs (vegasE)
	[10990] = 11035, -- mission_04_sfs => lod_sfs024 (SFSe)
	[10992] = 11038, -- mission_03_sfs => lod_sfs028 (SFSe)
	[5768] = 5937, -- taftbldg1_lawn => lodtbldg1_lawn (LaWn)
	[17852] = 17855, -- autoshpblok_lae2 => lodautoshpblok_lae (LAe2)
	[1260] = 1266, -- billbd3 => lodlbd3 (LAe)
	[12990] = 13483, -- sw_jetty => lodsw_jetty (countrye)
	[16110] = 16723, -- des_rockgp1_01 => lod_rockgp1_01 (countn2)
	[9484] = 9869, -- land_46_sfw => lodd_46_sfw (SFw)
	[16118] = 16717, -- des_rockgp2_05 => lod_rockgp2_05 (countn2)
	[4251] = 4386, -- sbcne_seafloor02 => lodseabed012 (seabed)
	[5782] = 5948, -- melblok12_lawn => lodblok12_lawn (LaWn)
	[10769] = 10894, -- airport_14_sfse => lodport_14_sfse (SFSe)
	[5274] = 5286, -- stormdraifr2_las2 => lodrmdraifr2_las2 (LAs2)
	[3283] = 3299, -- conhoos3 => lod_conhoos3 (countn2)
	[11285] = 11284, -- airport_14c_sfse => lodport_14c_sfse (SFSe)
	[3284] = 3301, -- conhoos5 => lod_conhoos5 (countn2)
	[3285] = 3300, -- conhoos4 => lod_conhoos4 (countn2)
	[11293] = 11294, -- facttanks_sfse08 => lodfacttanks_sfse08 (SFSe)
	[11295] = 11296, -- facttanks_sfse09 => lodfacttanks_sfse09 (SFSe)
	[5792] = 5840, -- fredricks01_lawn => loddricks01_lawn (LaWn)
	[3287] = 3296, -- cxrf_oiltank => lod_oiltank (countn2)
	[10281] = 10283, -- michsign_sfe => lodhsign_sfe (SFe)
	[1267] = 1261, -- billbd2 => lodlbd2 (LAe)
	[10287] = 10268, -- tempsf_4_sfe3 => lodpsf_4_sfe3 (SFe)
	[7938] = 7937, -- vegasnroad2469 => lodasnroad2469 (vegasW)
	[8150] = 8275, -- vgsselecfence04 => lodselecfence04 (vegasS)
	[8508] = 8821, -- genshop01_lvs => lodshop01_lvs (vegasE)
	[5291] = 5357, -- snpedscrsap_las01 => lodedscrsap_las02 (LAs2)
	[9228] = 9418, -- moresfnshit22 => lodesfnshit22 (SFn)
	[5398] = 5647, -- laetraintunn02 => lodlaetraintunn02 (LAe)
	[4088] = 4095, -- supports04_lan => lodsupports04_lan (LAn)
	[6934] = 6942, -- vegasplant09 => lodasplant09 (vegasN)
	[10817] = 10877, -- airprtgnd_03_sfse => lodprtgnd_03_sfse (SFSe)
	[12859] = 13193, -- sw_cont03 => sw_cont03_lod (countrye)
	[10056] = 9938, -- tempsf_4_sfe => loda05 (SFe)
	[5185] = 5197, -- brkwrhusfuk_las2 => lodwrhusfuk_las2 (LAs2)
	[17506] = 17570, -- stormdrainlae2_06 => lodrdrai2b_lae2 (LAe2)
	[17934] = 17935, -- coochieghous => lodcochieghos (LAe2)
	[12857] = 13387, -- ce_bridge02 => lodce_bridge02 (countrye)
	[7344] = 7345, -- vgsn_pipeworks => lodn_pipeworks (vegasN)
	[11088] = 11282, -- cf_ext_dem_sfs => lodext_dem_sfs (SFSe)
	[3426] = 3428, -- nt_noddonkbase => oilplodbitbase (countn2)
	[10792] = 11218, -- underfreeway_sfse => loderfreeway_sfse (SFSe)
	[3427] = 16273, -- derrick01 => oilderricklod01 (countn2)
	[17538] = 17932, -- powerstat1_lae2 => lod1powerstat1_lae (LAe2)
	[10843] = 10892, -- bigshed_sfse01 => lodbigshed_sfse03 (SFSe)
	[17546] = 17732, -- hydro3_lae => lod1hydro3_lae (LAe2)
	[9824] = 9826, -- diner_sfw => loder_sfw (SFw)
	[17554] = 17747, -- beachblok5_lae2 => lod1bchblok5_lae (LAe2)
	[10086] = 10081, -- aprtmnts03_sfe => loda39 (SFe)
	[5186] = 5200, -- nwsnpdnw_las2 => lodnpdnw_las2 (LAs2)
	[11111] = 11175, -- roadssfse57 => lodroadssfse57 (SFSe)
	[10857] = 11205, -- roadssfse12 => lodroadssfse12 (SFSe)
	[5191] = 5303, -- nwdkbridd_las2 => lodnwdkbridd_las (LAs2)
	[6368] = 6374, -- sunset03_law2 => lodset03_law2 (LAw2)
	[8568] = 8715, -- vgsebuild05_lvs => lodebuild05_lvs (vegasE)
	[10135] = 10217, -- road43_sfe => lodd43_sfe (SFe)
	[10357] = 10496, -- transmitter_sfs => lodnsmitter_sfs01 (SFs)
	[18359] = 18416, -- cs_landbit_74 => cs_lodbit_74 (countryS)
	[5724] = 5940, -- holsign03n_law => lodign03n_law (LaWn)
	[11128] = 11349, -- roadssfse75 => lodroadssfse75 (SFSe)
	[11420] = 11630, -- con_lighth => con_lighth_lod (countryN)
	[11132] = 11208, -- roadssfse79 => lodroadssfse79 (SFSe)
	[10369] = 10511, -- smallshop_10_sfs08 => lod_sfs045 (SFs)
	[4564] = 4579, -- laskyscrap2_lan => lodkyscrap2_lan (LAn2)
	[5728] = 5954, -- dummybuild46_law => lodmybuild46_law (LaWn)
	[3257] = 3288, -- refinerybox1 => lod_refinerybox1 (countn2)
	[4023] = 4226, -- newdbbuild_lan04 => lodnewdbbuild_lan04 (LAn)
	[3259] = 3424, -- refcondens1 => lod_refcondens1 (countn2)
	[10426] = 10542, -- backroad_sfs => lodroadssfs38 (SFs)
	[4570] = 4578, -- stolenbuilds08 => lodlenbuilds08 (LAn2)
	[8394] = 8823, -- vgsbox10sgn_lvs => lodbox10sgn_lvs (vegasE)
	[6867] = 6939, -- vegasplant06 => lodasplant06 (vegasN)
	[8859] = 8861, -- vgsecoast05 => lodecoast05 (vegasE)
	[4030] = 4138, -- lariversec4b_lan => lodlariversec4b_lan (LAn)
	[7520] = 7690, -- vgnlowbuild203 => lodlowbuild203 (vegasW)
	[8357] = 8360, -- vgssairportland14 => lodsairportland14 (vegasS)
	[17545] = 17724, -- barrio02_lae => lod1gangshops1_lae (LAe2)
	[12951] = 13263, -- sw_shopflat01 => lod13sw_shopflat01 (countrye)
	[10148] = 10258, -- bombshop => lodbshop (SFe)
	[5763] = 5932, -- bigbuillawn => lodbuillawn (LaWn)
	[3574] = 3744, -- lasdkrtgrp2 => lodlasdkrtgrp02 (LAs)
	[7388] = 7285, -- vrockpole => lodckpole (vegasN)
	[6879] = 6891, -- vegasnroad070 => lodasnroad070 (vegasN)
	[4585] = 4626, -- towerlan2 => lodtowerlan (LAn2)
	[4562] = 4698, -- laplaza2_lan => lodlaplaza2_lan (LAn2)
	[16601] = 16600, -- by_fuel07 => lod_watertwr05 (countn2)
	[4087] = 4093, -- supports03_lan => lodsupports03_lan (LAn)
	[10763] = 10884, -- controltower_sfse => lodtroltower_sfse (SFSe)
	[5355] = 5356, -- stordrablas2 => lod_stordrablas2 (LAs2)
	[9245] = 9381, -- cstguard_sfn01 => lodguard_sfn01 (SFn)
	[4257] = 4391, -- sbseabed_sfe03 => lodseabed021 (seabed)
	[3707] = 3708, -- rdwarhusmed => lod_rdwarhusmed (LAs2)
	[4090] = 4096, -- supports06_lan => lodsupports06_lan (LAn)
	[10433] = 10519, -- hashbury_04_sfs => lod_sfs056 (SFs)
	[4091] = 4097, -- supports07_lan => lodsupports07_lan (LAn)
	[18450] = 18538, -- cs_roadbridge04 => cs_roadbridge_lod01 (countryS)
	[10439] = 10518, -- hashbury_08_sfs => lod_sfs055 (SFs)
	[8403] = 8935, -- shop03_lvs => lodp03_lvs (vegasE)
	[9680] = 9681, -- tramstat_sfw => lodmstat_sfw (SFw)
	[5112] = 5255, -- laroads_26_las2 => lod_laroads_26 (LAs2)
	[11010] = 11048, -- crackbuild_sfs => lod_sfs047 (SFSe)
	[3330] = 3333, -- cxrf_brigleg => cxrf_lodbriglg (countn2)
	[3673] = 3682, -- laxrf_refinerybase => lod_refinerybase (countn2)
	[8546] = 8737, -- vgsewrehse02 => lodewrehse02 (vegasE)
	[6236] = 6240, -- canal_floor3 => lodcanal_floor3 (LAw)
	[11367] = 11368, -- airprtgnd_ct_sfse => lodprtgnd_ct_sfse (SFSe)
	[17507] = 17739, -- stormdrainlae2_03 => lod1stormdrai5_lae (LAe2)
	[6342] = 6475, -- century01_law2 => lodtury01_law2 (LAw2)
	[10977] = 11028, -- smallshop_16_sfs => lod_sfs017 (SFSe)
	[10979] = 11031, -- haightshop_sfs => lod_sfs020 (SFSe)
	[11387] = 11279, -- oldgarage_sfs => lod_hubgarage (SFSe)
	[4563] = 4566, -- laskyscrap1_lan => lodkyscrap1_lan (LAn2)
	[5126] = 5304, -- dockcranescale0 => loddockcranescale (LAs2)
	[17950] = 17952, -- cjsaveg => lodcjsaveg (LAe2)
	[3434] = 3482, -- skllsgn01_lvs => lodlsgn01_lvs (vegasE)
	[4109] = 4052, -- lariversec5_lan => lodlariversec5_lan (LAn)
	[9957] = 9972, -- multustor2_sfe => loda31 (SFe)
}