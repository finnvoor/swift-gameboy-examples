# Swift Game Boy Examples

A technical demonstration of Embedded Swift running on Game Boy Advance.

### Building the Example

1. Download and install a Swift nightly toolchain from [the Swift.org downloads page](https://www.swift.org/download/#snapshots).
2. Download `gba-llvm-devkit` from the [releases page](https://github.com/stuij/gba-llvm-devkit/releases).
3. Set `GBA_LLVM` in your environment to the path to the downloaded devkit (`export GBA_LLVM=<path to>/gba-llvm-devkit-1-Darwin-arm64`).
4. `cd` into one of the examples and run `make`.
5. Open the compiled `.gba` rom in a Game Boy emulator.
