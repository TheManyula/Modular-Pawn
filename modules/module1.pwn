// y_hooks needs to be included in ALL modules.
#include <YSI_Coding\y_hooks>

/*
native Mod1_GetModuleString(str[], size);
native Mod1_SetModuleString(const newString[]);
native Float:Mod1_GetModuleFloat();
native Mod1_SetModuleFloat(Float:float);
native Mod1_GetModuleInt();
native Mod1_SetModuleInt(int);
native Mod1_PrintModuleInfo();
native OnSomeStringModified(const oldString[], const newString[]);
*/

// Definitions and constants specific to module-1.
#define SOMESTRING_LEN 32

// Data
// This section is for module-internal data. Make sure to make the accessor variable 'static'.

enum MODULE_1_DATA {
    mod1_someString[SOMESTRING_LEN],
    mod1_someInt,
    Float:mod1_someFloat
}

static moduleInfo[MODULE_1_DATA];

// API
// This section contains functions for accessing or otherwise manipulating the data of this module.
// If you want a function to be used only inside of this module, use 'static' and camelCase.
// If you want a function to be accessible from other modules, use 'stock' and PascalCase.

stock Mod1_GetModuleString(str[], size) {
    strcat(str, moduleInfo[mod1_someString], size);
    return 1;
}

stock Mod1_SetModuleString(const newString[]) {
    new oldString[SOMESTRING_LEN];
    Mod1_GetModuleString(oldString, sizeof(oldString));
    format(moduleInfo[mod1_someString], sizeof(moduleInfo[mod1_someString]), newString);
    CallLocalFunction("OnSomeStringModified", "as", oldString, newString);
    return 1;
}

stock Float:Mod1_GetModuleFloat() {
    return moduleInfo[mod1_someFloat];
}

stock Mod1_SetModuleFloat(Float:float) {
    moduleInfo[mod1_someFloat] = float;
    return 1;
}

stock Mod1_GetModuleInt() {
    return moduleInfo[mod1_someInt];
}

stock Mod1_SetModuleInt(int) {
    moduleInfo[mod1_someInt] = int;
    return 1;
}

stock Mod1_PrintModuleInfo() {
    new string[SOMESTRING_LEN];
    Mod1_GetModuleString(string, sizeof(string));
    printf("mod1_someString: %s\nmod1_someFloat: %.2f\nmod1_someInt: %d", string, Mod1_GetModuleFloat(), Mod1_GetModuleInt());
    return 1;
}

// Implementation
// This section contains the concrete implementation for this module inside of the callbacks.

forward OnSomeStringModified(const oldString[], const newString[]);
public OnSomeStringModified(const oldString[], const newString[]) {
    // Custom callback which is called whenever SetModuleString is called.
    // Can be hooked in other modules.
    printf("public: oldString: %s | newString: %s", oldString, newString);
    return 1;
}

hook OnGameModeInit() {
    print("---------------------------------------------------------------\n");
    print("[module1]\n");
    print("Testing module interface:");
    Mod1_SetModuleString("Hello Module1!");
    Mod1_SetModuleFloat(3.41);
    Mod1_SetModuleInt(1337);
    Mod1_PrintModuleInfo();

    print("\nTesting utility function from utils/util.pwn:");

    new str[SOMESTRING_LEN];
    Mod1_GetModuleString(str, sizeof(str));
    printf("'%s' contains %d times the letter '%c'.", str, CountChars(str, "l"), 'l');

    print("\nTesting custom library function from libs/customlib.inc:");
    printf("The custom library function returned %d.", CustomLibRandomInt());

    print("\nTesting hooked function from utils/hooks.pwn:");
    SetPlayerScore(0, 10);
    return 1;
}
