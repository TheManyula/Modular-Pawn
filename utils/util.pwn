#include <YSI_Coding\y_hooks>

// Utility functions perform common, often re-used functions which are 
// helpful for accomplishing routine programming tasks. Examples might 
// include methods connecting to databases, performing string manipulations, 
// sorting and searching of collections of data, writing/reading data to/from 
// files and so on.
// All utility functions should be 'stock'.

stock CountChars(const string[], ch = EOS) {
    new i, found;
    while(string[i] != EOS) {
        if(string[i] == ch) {
            found++;
        }
        i++;
    }
    return found;
}