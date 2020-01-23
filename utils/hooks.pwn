#include <YSI_Coding\y_hooks>

hook function SetPlayerScore(playerid, score) {
	SetModuleInt(score);
	
	new msg[128];
	format(msg, sizeof(msg), "ID %d got %d score.", playerid, GetModuleInt());
	SendClientMessageToAll(-1, msg);
	print(msg);
	return continue(playerid, score);
}