## The idea here is just to lay out a simple template for ARM assembly projects.

## TLDR:
- Put your own source files in ```./src/```
- There must be **exactly ONE** ```_start``` label in the files in ```./src/```
- Run ```$ make```
- Object files are generated in ```./bin/```
- Use ```$ make run``` to run the application, ```$ make debugger``` to debug using gdb

### There is an example application in the ```./src/``` directory, This example is just there as a "hello world" that you can use to make sure everything works.

### When you go to make your own application, delete the example ```.s``` files in ```./src/``` and replace them with your own ```.s``` files.

#### Here is the directory structure before compiling anything:
```
.
├── LICENSE
├── Makefile
├── README.md
└── src
    ├── example_application.s
    └── example_dependency.s

1 directory, 5 files
```

#### And then after running ```$ make```:
```
.
├── bin
│   ├── example_application.o
│   ├── example_dependency.o
│   └── executable.out
├── LICENSE
├── Makefile
├── README.md
└── src
    ├── example_application.s
    └── example_dependency.s

2 directories, 8 files
```

### Note that the ```./bin/``` directory has been automatically generated and populated with one ```.o``` object file for each ```.s``` source file, as well as the ```executable.out``` file
