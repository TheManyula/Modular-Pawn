// y_hooks needs to be included in ALL modules.
#include <YSI_Coding\y_hooks>

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

// This next section contains functions for accessing or otherwise manipulating the data of this module.
// The API is divided into an external and an internal API.

// External API
// Functions accessible from other modules. Use 'stock' and PascalCase.

stock Mod1_GetModuleString(string[], size) {
    strcat(string, moduleInfo[mod1_someString], size);
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

stock Mod1_SetModuleInt(integer) {
    moduleInfo[mod1_someInt] = integer;
    return 1;
}

// Internal API
// Functions to be used only inside of this module. Use 'static (stock)' and camelCase.

static stock printModuleInfo() {
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
    print("[module1]");
    print("\nTesting module interface:");
    Mod1_SetModuleString("Hello Module1!");
    Mod1_SetModuleFloat(3.41);
    Mod1_SetModuleInt(1337);
    printModuleInfo();

    print("\nTesting utility function from utils/util.pwn:");
    new string[SOMESTRING_LEN];
    Mod1_GetModuleString(string, sizeof(string));
    printf("'%s' contains %d times the letter '%c'.", string, CountChars(string, "l"), 'l');

    print("\nTesting custom library function from libs/customlib.inc:");
    printf("The custom library function returned %d.", CustomLibRandomInt());

    print("\nTesting hooked function from utils/hooks.pwn:");
    SetPlayerScore(0, 10);
    return 1;
}
