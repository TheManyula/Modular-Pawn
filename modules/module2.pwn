// y_hooks needs to be included in ALL modules.
#include <YSI_Coding\y_hooks>

// Checking if module1's define has been done already.
#if defined _included_module1
    // If _included_module1 has been defined already. If so, end the input.
    // Using #endinput breaks the inclusion progress of THIS include only.
    // It's a Pawn directive which doesn't harm other includes.
    #endinput
// Ending the if statement which was started.
#endif 

// Now the key which has been checked as if it's defined or not has to be defined before anything.
#define _included_module1

// Now your include KEY define has been defined and you can include the external module.
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
