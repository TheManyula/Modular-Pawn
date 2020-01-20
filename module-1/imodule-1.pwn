// Definitions and constants specific to module-1.
#define SOMESTRING_LEN 32

// Forward all non-static functions of module-1.
forward GetModuleString(str[SOMESTRING_LEN]);
forward SetModuleString(const newString[SOMESTRING_LEN]);
forward Float:GetModuleFloat();
forward SetModuleFloat(Float:float);
forward GetModuleInt();
forward SetModuleInt(int);

// Forward all custom callbacks of module-1.
forward OnSomeStringModified(const oldString[], const newString[]);