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

// Interface
// This section contains functions for accessing or otherwise manipulating the data of this module.
// If you want a function to be used only inside of this module, use 'static'.
// If you want a function to be accessible from other modules, use 'stock'.

stock GetModuleString(str[], size) {
    format(str, size, moduleInfo[someString]);
}

stock SetModuleString(const newString[]) {
    new oldString[SOMESTRING_LEN];
    GetModuleString(oldString, sizeof(oldString));
    format(moduleInfo[someString], sizeof(moduleInfo[someString]), newString);
    // CallLocalFunction("OnSomeStringModified", "ss", oldString, newString);
    return 1;
}

stock Float:GetModuleFloat() {
    return moduleInfo[someFloat];
}

stock SetModuleFloat(Float:float) {
    moduleInfo[someFloat] = float;
}

stock GetModuleInt() {
    return moduleInfo[someInt];
}

stock SetModuleInt(int) {
    moduleInfo[someInt] = int;
}

static PrintModuleInfo() {
    new string[SOMESTRING_LEN];
    GetModuleString(string, sizeof(string));
    printf("someString: %s\nsomeFloat: %.2f\nsomeInt: %d", string, GetModuleFloat(), GetModuleInt());
}

// Implementation
// This section contains the concrete implementation for this module inside of the callbacks.

public OnSomeStringModified(const oldString[], const newString[]) {
    printf("public: oldString: %s | newString: %s", oldString, newString);
    return 1;
}

hook OnGameModeInit() {
    SetModuleString("Hello World!");
    SetModuleFloat(3.41);
    SetModuleInt(1337);

    PrintModuleInfo();

    new str[SOMESTRING_LEN];
    GetModuleString(str, sizeof(str));
    printf("'%s' contains %d times the letter '%c'.", str, CountChars(str, "l"), 'l');

    printf("The custom library function returned %d.", CustomLibRandomInt());
    return 1;
}
