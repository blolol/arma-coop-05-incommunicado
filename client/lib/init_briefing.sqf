/**
 * Initializes mission briefing.
**/

player createDiaryRecord [
	"Diary",
	[
		localize "@STR_BLOL_C_BRIEFING_TRANSPORT_TITLE",
		format [
			localize "@STR_BLOL_C_BRIEFING_TRANSPORT_CONTENT",
			"<br /><br />", // %1
			"</marker>", // %2
			(format ["<marker name='%1'>", BLOL_outpostMarker]) // %3
		]
	]
];

player createDiaryRecord [
	"Diary",
	[
		localize "@STR_BLOL_C_BRIEFING_MISSION_TITLE",
		format [
			localize "@STR_BLOL_C_BRIEFING_MISSION_CONTENT",
			"<br /><br />" // %1
		]
	]
];
