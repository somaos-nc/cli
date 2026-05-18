# Cli - Terminal Emulator

A highly customized, GPU-accelerated Native C/GTK3 terminal emulator built around the VTE engine. 
Originally prototyped in Flutter, this project was rewritten in C to leverage native GTK3 and Pango rendering, enabling flawless text shaping, complete bidirectional text (RTL) support (like Hebrew/Arabic), and maximum system integration.

## Features
- **Native Layout Splitting:** Right-click anywhere in the terminal to split the view infinitely horizontally or vertically via native `GtkPaned` layouts.
- **Smart Directory Tracking:** When splitting a pane, the new terminal inherits the exact working directory of the active process.
- **Flawless RTL & TrueColor:** Powered by VTE and Pango for perfect Bidi text shaping and 24-bit ANSI colors.
- **State Persistence:** The app saves your exact window splits, current working directories, and active theme on exit, instantly reconstructing your workspace when you reopen the application.
- **Theme Engine:** Includes a suite of creative, built-in dynamic color palettes (Cyberpunk Neon, Solar Flare, Deep Ocean, Hacker Green, Default Dark).
- **Clean UI:** Hides default OS window borders in favor of a sleek, unified `GtkHeaderBar` containing the custom glowing app icon.

## Prerequisites
You will need a standard C build environment along with GTK3, VTE, and Fontconfig headers.

### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install build-essential libgtk-3-dev libvte-2.91-dev libfontconfig1-dev
```

### On macOS (Homebrew):
```bash
brew install pkg-config gtk+3 vte3 adwaita-icon-theme
```

## Building and Running
To build the application locally:

**Linux:**
```bash
make
./cli
```

**macOS:**
```bash
make -f Makefile.macos
./cli
```

## Testing
This project contains a mock `test_main.c` test suite that asserts the UI logic and hierarchy manipulation.
To run the tests with GCOV coverage tracking:
```bash
make test
```

## Packaging
You can generate platform-specific installers.

**Linux (Debian):**
```bash
./build_deb.sh
sudo dpkg -i releases/cli_1.0.2_amd64.deb
```

**macOS (.app & .dmg):**
```bash
./build_osx.sh
```
The resulting DMG will be located in `releases/cli_1.0.2_macOS.dmg`.
