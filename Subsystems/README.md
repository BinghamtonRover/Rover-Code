# Subsystems (Dart)

This repository contains the code for the Subsystems program, which is responsible for sending CAN messages over UDP and vice-versa, integrating the Dashboard with the various subsystems. 

## Running the code

The Dart code loads some shared C libraries at runtime. This means those libraries must be compiled and generated beforehand. These libraries only need to be compiled once on your system, unless they are modified.

### Compiling C code on Linux

In the `src` folder, run `make` to generate `src/can.so` and `libserialport.so`

### Compiling C code on Windows

SocketCAN is not supported on Windows, so to compile `libserialport.dll`, simply run `winbuild`. This command must be run with `cmake` on your PATH. The easiest way to do this is to run it with the `Developer Command Prompt for Visual Studio`, which can be found in the Start menu if you've installed Visual Studio (_not_ Visual Studio Code).

### Running the Dart code

Simply run

```bash
dart run
```

If you'd like to run a different script in the `bin` folder, just run `dart run :script`.
