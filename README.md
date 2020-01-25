# Modular Programming in Pawn

This project aims to show a modular approach to scripting in Pawn for SA:MP/open.mp.

## Motivation

When you started out scripting with Pawn, you probably didn't care much about code architecture as long as
the code did what you wanted it to do. For the purpose of learning, you're actually encouraged to get your
hands dirty writing some really shoddy code that you will look back on with shame one day.
At some point, you may have decided to write your own gamemode and started out by putting everything into
one single file simply because you were used to it or didn't know any better. Many have held onto this style
and chances are you have too.

As your gamemode kept growing in size, you have probably noticed that things started to get messy.
Adding new features, removing old ones or even fixing bugs became harder and harder. God forbid you have to
work with someone else's spaghetti code. Luckily, there is a solution to this - and it's called modular programming.

## Concepts

In software development, there is this notion of tightly coupled and loosely coupled code which indicate
to what degree individual components rely on each other. This translates directly to how easy it is to replace
or change them.

- Tightly coupled code is rigid and highly cohesive. Every part of the code makes assumptions about every
  other part of the code. On paper, this can sometimes result in _slightly_ more performant code.
- Loosely coupled code by contrast is separated. Every part of the code communicates with other parts
  through more or less standardized and neutral interfaces. This makes the code much easier to understand
  and maintain.

At first glance, a monolithic approach might look easier. After all, everything you need is in one place. Popular
gamemodes like "The Godfather" did it this way which is probably one of the reasons why people are still structuring
their code by declaration type. It may look clean but actually just causes a huge mess in the long run as logically
related code parts are scattered everywhere. This keeps getting worse as your gamemode grows in size.

Modular programming seems pretty intimidating at first since there are a couple of things to learn and to get
used to. But don't worry, it's not as hard as you may think and once you get the hang of it, you'll never go
back if you don't have to. In the context of SA:MP/open.mp, the increased readability and maintainability
of a modular gamemode completely outweigh the tiny performance increase in a monolithic one (which you and your players
probably won't notice anyway).

## Terminology

### Module

A module is a logically seperated software component that ideally provides only one single functionality.
It typically consists of one or more .pwn files that interact with each other through an API (Application
Programming Interface). An example of a module would be a house system or a race system.

### Interface

An interface and denotes a set of functions in a module that is meant to be accessed by external modules.
An example would be getter and setter functions to access data from another module.

## Prerequisites

- [sampctl package manager](https://github.com/Southclaws/sampctl) (For a list of libraries that support sampctl, check out the [Pawndex](https://packages.sampctl.com/).)
  - [YSI Framework](https://github.com/pawn-lang/YSI-Includes/tree/5.x) (Familiarize yourself with [y_hooks](https://github.com/pawn-lang/YSI-Includes/blob/5.x/YSI_Coding/y_hooks.md).)
- [Visual Studio Code](https://code.visualstudio.com/)

## Folder Structure

- `config/` contains global definitions/constants.
- `dependencies/` is managed by sampctl and contains all dependencies.
- `filterscripts/` contains all filterscripts. Check out the [sampctl documentation](https://github.com/Southclaws/sampctl/wiki/Filterscripts) on how to add filterscripts to your gamemode.
- `gamemodes/` contains the `main.pwn` entry script which contains the main game loop and connects all modules in one place for compilation.
- `libs/` contains all of your custom libraries that are not yet a sampctl package or that you don't want to publish. Be sure to install all necessary dependencies for these yourself as sampctl does not cover them!
- `modules/` is a folder to put your modules in.
- `plugins/` contains all non-sampctl plugins.
- `scriptfiles/` contains files needed by plugins.
- `utils/` contains utility or helper functions for common programming tasks.

### Entry Script

The entry script should always have the following layout.
This makes sure that...

1. the compiler doesn't need to reparse for functions used ahead of declaration.
2. modules can be included in any order.

```pawn
#include <a_samp> // Includes all of SA-MP's natives.

// Configuration
#include "../config/const.pwn" // Contains your gamemode-specific definitions, like colors, cardinal directions, etc.

// Utilities
#include "../utils/hooks.pwn" // Contains functions hooks.
#include "../utils/util.pwn" // Contains utility and helper functions.

// Dependencies
#include <YSI_Coding\y_hooks> // Must be included in the entry script and in EVERY single module that uses hooks.

// Custom libraries
#include "../libs/customlib.inc" // Contains all non-sampctl libraries.

// Modules
#include "../modules/<module>.pwn" // Contains data and implementation logic of module.

main() {} // Ensures we can actually run our script.
```

## Quick Start

1. Create a project folder for your gamemode.
2. Use the command line to navigate to your gamemode folder and type `sampctl package init`.
3. Download YSI 5.x using `sampctl package install pawn-lang/YSI-Includes@5.x`.
4. Create the `gamemodes/` folder and put the entry script `main.pwn` inside. Don't forget to give it a `main() {}` function and `#include <a_samp>`!
5. Create the rest of the folder structure according to the layout above.
6. Create a new `.pwn` file in the `modules/` directory, put an `#include <YSI_Coding\y_hooks>` on top and start scripting!

## Best Practices

- If a module needs to access the external API of another module it must be included. Do this for EVERY module. The built-in include guard takes care of redundant inclusion for you if you use sampctl (managed by the `-Z+` flag).
- Access your data both inside the module itself as well as from other modules via your internal API.
- Use camelCase for your internal API and PascalCase for your external API.
- Use variable and function prefixes to avoid duplicate names.
- Keep a commented list of natives on top of the module.
- Constants/defines for module-internal use should only be defined inside of the module. For global constants/defines, use the `config/const.pwn` or the build configuration found in your `pawn.json`.
