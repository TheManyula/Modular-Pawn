// y_hooks needs to be included in ALL modules.
#include <YSI_Coding\y_hooks>

// Module2 makes use of Module1's external API, so include it.
#include "../modules/module1.pwn"

// Data
// This section is for module-internal data. Make sure to make the accessor variable 'static'.

// No data

// API
// This section contains functions for accessing or otherwise manipulating the data of this module.
// If you want a function to be used only inside of this module, use 'static' and camelCase.
// If you want a function to be accessible from other modules, use 'stock' and PascalCase.

// No API

// Implementation
// This section contains the concrete implementation for this module inside of the callbacks.

hook OnGameModeInit() {
    print("---------------------------------------------------------------\n");
    print("[module2]\n");
    print("Testing module interface:");
    Mod1_SetModuleString("Hello Module2!");
    Mod1_SetModuleFloat(2.71);
    Mod1_SetModuleInt(8080);
    Mod1_PrintModuleInfo();

    print("\nTesting utility function from utils/util.pwn:");

    new str[SOMESTRING_LEN];
    Mod1_GetModuleString(str, sizeof(str));
    printf("'%s' contains %d times the letter '%c'.", str, CountChars(str, "e"), 'e');

    print("\nTesting custom library function from libs/customlib.inc:");
    printf("The custom library function returned %d.", CustomLibRandomInt());

    print("\nTesting hooked function from utils/hooks.pwn:");
    SetPlayerScore(0, 10);
    return 1;
}

hook OnSomeStringModified(const oldString[], const newString[]) {
    print("Hooked OnSomeStringModified in module2.");
    return 1;
}
