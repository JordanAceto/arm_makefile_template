#-------------------------------------------------------------------------------|
# This is an attempt at a generic Arm assembly Makefile for use on the 
# Raspberry pi 3b+ running raspbian.
#
# The idea is this: put this Makefile in a directory with one or more assembly
# source files which end in the .s extension. Exactly one of these files must
# have a globally visible _start label. Run $ make, $ make run,... etc. to 
# build and execute your application. 
#
# Multiple files are automatically detected, assembled, and linked. You don't 
# need to tell it the name of the files or how many files there are or any 
# nonsense, just paste this Makefile in the directory and go.
# 
# This Makefile does not currently work if you branch to standard c-functions
# like printf, it only works with straight assembly. It could probably be 
# modified to work either way though, so you could either have exactly one
# _start label, OR exactly one main label (if you were calling c-functions).
#
# Notes on some of the weird syntax: the $@ symbol means "the first argument
# from above", the $< symbol means "the second argument from above", the $^
# symbol means "the whole list of the second argument from above".
# A single '@' at the start of a line means "don't print this to the terminal".
# 
# I'm just goofing around with this, and don't really know what I'm doing, so
# if you see something dumb, let me know.
#-------------------------------------------------------------------------------|

#-------------------------------------------------------------------------------|
# set this flag to 1 to generate debug symbols for gdb, zero for non-debug build
#-------------------------------------------------------------------------------|
DEBUG_BUILD = 1

#-------------------------------------------------------------------------------|
# Assembler make variables
#-------------------------------------------------------------------------------|
ASSEMBLE = as

# conditionally add debug flag to the assembler flags
ifeq ($(DEBUG_BUILD), 1)
ASM_FLAGS += -g
endif
ASM_FLAGS += -o

#-------------------------------------------------------------------------------|
# Linker make variables
#-------------------------------------------------------------------------------|
LINK = ld

LINKER_FLAGS += -o

#-------------------------------------------------------------------------------|
# Objdump make variables
#-------------------------------------------------------------------------------|
OBJDUMP = objdump

OBJDUMP_FLAGS += -d
OBJDUMP_FLAGS += -s

#-------------------------------------------------------------------------------|
# Debugger make variables
#-------------------------------------------------------------------------------|
DEBUGGER = gdb

DEBUGGER_FLAGS += -tui

#-------------------------------------------------------------------------------|
# Directory to put all .s source files
#-------------------------------------------------------------------------------|
SRC_DIR = ./src/

#-------------------------------------------------------------------------------|
# Directory to put all .o and .out files that are built
#-------------------------------------------------------------------------------|
BIN_DIR = ./bin/

#-------------------------------------------------------------------------------|
# The executable, this is our main target
#-------------------------------------------------------------------------------|
EXECUTABLE = $(BIN_DIR)executable.out

#-------------------------------------------------------------------------------|
# This automatically collects up any source files/object files
#-------------------------------------------------------------------------------|
ASM_OBJECT_FILES := $(patsubst $(SRC_DIR)%.s, $(BIN_DIR)%.o,$(wildcard $(SRC_DIR)*.s))

#-------------------------------------------------------------------------------|
# Recipes 
#-------------------------------------------------------------------------------|

# default target makes the executable file
all: $(BIN_DIR) $(EXECUTABLE)

# this assembles all .s source files into object files of the same name
$(BIN_DIR)%.o: $(SRC_DIR)%.s
	$(ASSEMBLE) $(ASM_FLAGS) $@ $<

# make the executable
$(EXECUTABLE): $(ASM_OBJECT_FILES)
	$(LINK) $(LINKER_FLAGS) $@ $^

# run the executable
run: $(EXECUTABLE)
	@./$<

# dump the disassembly to the terminal
dump: $(EXECUTABLE)
	$(OBJDUMP) $(OBJDUMP_FLAGS) $< | less

# load the executable into gdb, make sure you are running a debug build first
debugger: $(EXECUTABLE)
	$(DEBUGGER) $< $(DEBUGGER_FLAGS)

# if the bin directory does not exist, make it
$(BIN_DIR):
	mkdir $@

# tidy up the directory
clean:
	rm -f $(ASM_OBJECT_FILES)
	rm -f $(EXECUTABLE)
