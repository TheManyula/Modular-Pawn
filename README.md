# Modular Programming in Pawn

This project aims to show a modular approach to scripting in Pawn for SA:MP/open.mp.
For a detailed documentation, please check out the wiki.

## Prerequisites

- [sampctl package manager](https://github.com/Southclaws/sampctl) (For a list of libraries that support sampctl, check out the [Pawndex](https://packages.sampctl.com/).)
  - [YSI Framework](https://github.com/pawn-lang/YSI-Includes/tree/5.x) (Familiarize yourself with [y_hooks](https://github.com/pawn-lang/YSI-Includes/blob/5.x/YSI_Coding/y_hooks.md).)
- [Visual Studio Code](https://code.visualstudio.com/)

## Best Practices

- If a module needs to access the external API of another module it must be included. Do this for EVERY module. The built-in include guard takes care of redundant inclusion for you if you use sampctl (managed by the `-Z+` flag).
- Access your data both inside the module itself as well as from other modules via your internal API.
- Use camelCase for your internal API and PascalCase for your external API.
- Use variable and function prefixes to avoid duplicate names.
- Constants/defines for module-internal use should only be defined inside of the module. For global constants/defines, use the `config/const.pwn` or the build configuration found in your `pawn.json`.
