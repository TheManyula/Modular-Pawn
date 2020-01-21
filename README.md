# Modular Programming in Pawn

This project aims to show a modular approach to scripting in Pawn for SA:MP.

## Motivation

When you started out scripting with Pawn, you probably didn't care much about code architecture as long as
the code did what you wanted it to do. For the purpose of learning, you're actually encouraged to get your
hands dirty writing some really shoddy code that you will look back on with shame one day in the future.
At some point, you may have decided to write your own gamemode and chances are you've held onto putting
everything into one single file simply because you were used to it or didn't know any better.

As your gamemode kept growing in size, you have probably noticed that things were starting to get really messy.
Adding new features, removing old ones or even fixing bugs became harder and harder. Luckily, there is a
solution to this - and it's called modular programming.

## Concepts

In software development, there is this notion of tightly coupled and loosely coupled code bases that indicate
to what degree individual components rely on each other. This translates directly to how easy it is to replace
or change them.

- Tightly coupled code is rigid and highly cohesive where every part of the code makes assumptions about every
  other part ot the code. On paper, this can sometimes result in slightly more performant code.
- Loosely coupled code by contrast is separated where every part of the code communicates with other parts
  through more or less standardized and neutral interfaces. This makes the code base much easier to understand
  and maintain.

At first glance, a monolithic approach might look easier. After all, everything you need is in one place. Popular
gamemodes like The Godfather did it this way which is probably one of the reasons why people are still structuring
their code by declaration type. It may look clean but actually just causes a huge mess in the long run as logically
related code parts are scattered everywhere. This keeps getting worse as your gamemode grows in size.

Modular programming seems pretty intimidating at first since there are a couple of things to learn and to get
used to. But don't worry, it's not as hard as you may think and once you get the hang of it, you'll never go
back. The increased readability and maintainability of a modular gamemode completely outweigh the negligible
performance increase in a monolithic one.

## Terminology

### Module

A module is a logically seperated software component that ideally provides only one single functionality.
It typically consists of one or more .pwn files that interact with each other through an API (Application
Programming Interface). An example of a module would be a house system or a race system.

### Interface

An interface and denotes a set of functions in a module that is meant to be accessed by external modules.
An example would be getter and setter functions to access data (static variables) from another module.

## Prerequisites

- [sampctl package manager](https://github.com/Southclaws/sampctl) (For a list of libraries that support sampctl, check out the [Pawndex](https://packages.sampctl.com/).)
- [Visual Studio Code](https://code.visualstudio.com/)

## Folder Structure

- `config/` contains global definitions/constants.
- `dependencies/` is managed by sampctl and contains all dependencies.
- `[module]/` is a folder for a module. It contains...
  - a `[module].pwn` file for data and implementation logic, and
  - a `i[module].pwn` file for forward declarations of functions meant to be accessible from other modules.
- `utils/` contains utility or helper functions for common programming tasks.
- `main.pwn` ist the entry script which contains the main game loop and connects all modules in one place for compilation.

### Entry Script

To make it work, the entry script should always have the following layout.
This makes sure that...

1. the compiler doesn't need to reparse for functions used ahead of declaration.
2. modules can be included in any order.

```pawn
#include <a_samp> // Includes all of SA-MP's natives.

// Configuration
#include "config/config.pwn" // Contains definitions for YSI or other feature toggles.
#include "config/const.pwn" // Contains your gamemode-specific definitions, like colors, cardinal directions, etc.

// Utilities
#include "utils/hooks.pwn" // Contains functions hooks.
#include "utils/util.pwn" // Contains utility and helper functions.

// Dependencies
#include <YSI_Coding\y_hooks> // Must be included in the entry script and in EVERY single module that uses hooks.

// Interfaces
#include "module-1/imodule-1.pwn" // Contains forward declarations of modules.

// Modules
#include "module-1/module-1.pwn" // Contains data and implementation logic of module.

main() {} // Ensures we can actually run our script.
```

## Quick Start

1. Create a project folder for your gamemode.
2. Use the command line to navigate to your gamemode folder and type `sampctl package init`.
3. Download YSI 5.x using `sampctl package install pawn-lang/YSI-Includes@5.x`.
4. Create the entry script `main.pwn` according to the layout above.
5. Create the rest of the folder structure, so `config` and `utils`.
6. Create a new folder for a new module, create the [module].pwn and i[module].pwn files and start scripting!
