// y_hooks needs to be included in ALL modules.
#include <YSI_Coding\y_hooks>

// Data
// This section is for module-internal data. Make sure to make the accessor variable 'static'.
enum MODULE_1_DATA {
    someString[SOMESTRING_LEN],
    someInt,
    Float:someFloat
}

static moduleInfo[MODULE_1_DATA];

// API
// This section contains functions for accessing or otherwise manipulating the data of this module.
// If you want a function to be used only inside of this module, use 'static' and camelCase.
// If you want a function to be accessible from other modules, use 'stock' and PascalCase.

stock GetModuleString(str[], size) {
    strcat(str, moduleInfo[someString], size);
    return 1;
}

stock SetModuleString(const newString[]) {
    new oldString[SOMESTRING_LEN];
    GetModuleString(oldString, sizeof(oldString));
    format(moduleInfo[someString], sizeof(moduleInfo[someString]), newString);
    CallLocalFunction("OnSomeStringModified", "as", oldString, newString);
    return 1;
}

stock Float:GetModuleFloat() {
    return moduleInfo[someFloat];
}

stock SetModuleFloat(Float:float) {
    moduleInfo[someFloat] = float;
    return 1;
}

stock GetModuleInt() {
    return moduleInfo[someInt];
}

stock SetModuleInt(int) {
    moduleInfo[someInt] = int;
    return 1;
}

static printModuleInfo() {
    new string[SOMESTRING_LEN];
    GetModuleString(string, sizeof(string));
    printf("someString: %a\nsomeFloat: %.2f\nsomeInt: %d", string, GetModuleFloat(), GetModuleInt());
    return 1;
}

// Implementation
// This section contains the concrete implementation for this module inside of the callbacks.

public OnSomeStringModified(const oldString[], const newString[]) {
    // Custom callback which is called whenever SetModuleString is called.
    // Can be hooked in other modules.
    printf("public: oldString: %s | newString: %s", oldString, newString);
    return 1;
}

hook OnGameModeInit() {
    print("Testing module interface:");
    SetModuleString("Hello World!");
    SetModuleFloat(3.41);
    SetModuleInt(1337);

    printModuleInfo();

    print("\nTesting utility function from utils/util.pwn:");

    new str[SOMESTRING_LEN];
    GetModuleString(str, sizeof(str));
    printf("'%s' contains %d times the letter '%c'.", str, CountChars(str, "l"), 'l');

    print("\nTesting custom library function from libs/customlib.inc:");
    printf("The custom library function returned %d.", CustomLibRandomInt());

    print("\nTesting hooked function from utils/hooks.pwn:");
    SetPlayerScore(0, 10);
    return 1;
}
