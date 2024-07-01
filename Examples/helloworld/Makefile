ifeq ($(strip $(GBA_LLVM)),)
$(error "Please set GBA_LLVM in your environment. export GBA_LLVM=<path to>/gba-llvm-devkit-1-Darwin-arm64")
endif

RELATIVE_TOOLCHAIN_PATH = Library/Developer/Toolchains/swift-latest.xctoolchain
ifneq ($(TOOLCHAIN),)
else ifneq ($(wildcard $(HOME)/$(RELATIVE_TOOLCHAIN_PATH)),)
TOOLCHAIN = $(HOME)/$(RELATIVE_TOOLCHAIN_PATH)
else ifneq ($(wildcard /$(RELATIVE_TOOLCHAIN_PATH)),)
TOOLCHAIN = /$(RELATIVE_TOOLCHAIN_PATH)
else
$(error "Please set TOOLCHAIN in your environment. export TOOLCHAIN=<path to swift.xctoolchain>")
endif

NAME = helloworld

SWIFTC = $(TOOLCHAIN)/usr/bin/swiftc
BIN = $(GBA_LLVM)/bin
LLD = $(BIN)/ld.lld
GBAFIX = $(BIN)/gbafix

INCLUDE_PATH = $(GBA_LLVM)/lib/clang-runtimes/arm-none-eabi/armv4t/include
LIB_PATH = $(GBA_LLVM)/lib/clang-runtimes/arm-none-eabi/armv4t/lib

SWIFT_FLAGS = -wmo -parse-as-library -enable-experimental-feature Embedded -target armv4t-none-none-eabi -Osize
LFLAGS = -T$(LIB_PATH)/gba_cart.ld
SWIFT_FILES = *.swift

LIBS = $(wildcard $(LIB_PATH)/*.a)

$(NAME).gba: $(NAME).elf
	$(BIN)/llvm-objcopy -O binary $^ $@
	$(GBAFIX) $@

$(NAME).elf: $(SWIFT_FILES)
	$(SWIFTC) $(SWIFT_FLAGS) -c $^ -o $(NAME).o
	$(LLD) $(LFLAGS) -o $@ $(NAME).o $(LIBS)

.PHONY: clean

clean:
	rm -f $(NAME).elf $(NAME).gba $(NAME).o
