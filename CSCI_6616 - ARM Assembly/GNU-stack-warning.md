## Fix GNU-stack warning
* Original link: https://www.redhat.com/en/blog/linkers-warnings-about-executable-stacks-and-segments

* Fixing this warning involves tracking down which object files do not have .note.GNU-stack sections and then either recompiling them with a new compiler or updating the assembler source code to include a declaration of a .note.GNU-stack section. 

* It is possible to use the readelf program to determine if an object file does not contain a .note.GNU-stack section by running a command like this:

``` readelf -x.note.GNU-stack <file>```
* If readelf reports that it “has no data to dump”  then the section is missing. Readelf can handle multiple object files and libraries, but it will not recurse into directories. So it may be necessary to create a script to search a complicated build tree. If the annocheck program version 10.80 or later is available, this command can be used to search an entire directory tree:

```
annocheck --disable-hardened –ignore-unknown –ignore-links \
--size-sec=.note.GNU-stack --size-missing <directory>
 ```
Updating assembler source code to create a .note.GNU-stack section just means adding a line like this:

```
.section  .note.GNU-stack, “”, @progbits
```
If the assembler code does need an executable stack then the line should looks like this:

```
.section  .note.GNU-stack, “x”, @progbits
```
Alternatively linking with the ```-z no-exec-stack``` command line option will tell the linker to ignore the missing .note.GNU-stack sections and instead just assume that one was present, but that it was not marked as needing an executable stack. If truly needed the -z execstack option could be used instead, which will also ignore the missing sections, but it will then create an executable stack.

## Original article
In this article I talk about some new warning messages that have been added to the BFD linker.  What they mean, why they are important and what can be done to prevent or silence them.

Note: These warnings are currently specific to the BFD linker (ld.bfd) but similar warnings may appear in the gold, lld and mold linkers in the future.

The new warnings
With release 2.39 of the GNU Binutils several new warnings have been added to the linker.  While new warnings are not normally an issue, these ones are special as they have the potential to be triggered on programs that have previously compiled and linked without any problems. 

The warnings cover two related areas—the program’s stack and the program’s code and data segments.  Both of these are prime targets for attackers—if they can insert instructions into either region, then they can use them as stepping stones to take over the program. This is normally prevented by making sure that neither the stack nor the data segment can contain code and that the code segment cannot be modified. The new warnings are there to alert developers when these safety conditions are not in place.

Sometimes there are good reasons for having an executable stack or a writable code segment. It may be needed by the program loader in order to make a program work, or it could be needed by the compiler in order to implement a specific feature of the program. But it is better that the developer knows that this is happening, and that their programs are potentially vulnerable, rather than they live in ignorance.

The linker does provide command line options to turn off the warnings, and it can even be built with the warnings disabled by default. But the point of this blog is to provide a reference for developers who encounter the warnings and wonder what they can do about them.

The executable stack warnings
The program’s stack is used to record information about function calls—where they come from, what their arguments are and so on. It should never normally contain any code of its own, and hence it should never have the executable attribute. When it is made executable the linker will generate one of these warning messages:

warning: enabling an executable stack because of -z execstack command line option

This warning indicates that an executable stack has been explicitly requested via a linker command line option (-z execstack) and it is there just as a reminder. The warning can be suppressed via the –no-warn-exec-stack command line option. But it might also be worth investigating why the -z execstack option was used in the first place. If the program works without it, then it is better not to use it at all.

warning: <file>: requires executable stack (because the .note.GNU-stack section is executable)

The second form of the warning is generated when an executable stack has been requested by the compiler. There are circumstances where a compiler will decide that it really needs an executable stack, and there is a mechanism for telling the linker about this. See Hardened/GNU stack quickstart and Executable stack for more information on the method used and the reasons why a compiler might want an executable stack.

It is unusual for a compiler to need an executable stack, however, and the best way to remove the warning is to rework the source code so that the need is removed. For example, eliminating nested functions might be one solution. (Nested functions are an extension to the C language supported by GCC and some other compilers. See Nested Functions for more information).

For example, the following C code needs an executable stack:

extern int foo (int (*)(int));
int bar (int arg)
{
  int baz (int arg2) { return arg2 * arg; }
  return foo (& baz) + arg;
}
The issue here is that the nested function baz() cannot be created at compile time because it uses the arg parameter of bar() but it also has to exist because its address is passed to foo().  So the compiler arranges for baz() to be constructed on the stack at run time.

The code could be rewritten like this:

extern int foo (int (*)(int));
static int saved_arg = 1;
static int baz (int arg2) { return arg2 * saved_arg; }
int bar (int arg)
{
  int res;
  int prev_saved_arg = saved_arg;
  
  saved_arg = arg;
  res = foo (& baz) + arg;
  saved_arg = prev_saved_arg;
  return res;
}
This eliminates the need to construct baz() at run time, and hence the need for an executable stack, but it does also render the code unsafe if it is used in a multithreaded environment.

Finding the code which requires an executable stack involves first locating the object file that has a .note.GNU-stack section with an executable flag set. The readelf command can be combined with grep to check a given file, like this:

readelf -SW <file> | grep .note.GNU-stack | grep X
Searching multiple files, libraries and directories will be more difficult and will probably require writing a script. If the annocheck program is available, however, it can be used to perform this task like this:

annocheck --disable-hardened –ignore-unknown –ignore-links \
--size-sec-flags=X -v <directory> | grep .note.GNU-stack
warning: <file>: missing .note.GNU-stack section implies executable stack

The final form of the warning is the most serious as it is alerting the developer to the fact that the program is being given an executable stack when it may not be expected. That is, it has not been requested by an option on the linker command line, nor by the compiler. This happens when the program is linked with one or more object files which have not been marked as needing or not needing an executable stack. Such object files are either created from assembler source code, or by older compilers which do not know about the method used to communicate stack requirements to the linker.

Fixing this warning involves tracking down which object files do not have .note.GNU-stack sections and then either recompiling them with a new compiler or updating the assembler source code to include a declaration of a .note.GNU-stack section. 

It is possible to use the readelf program to determine if an object file does not contain a .note.GNU-stack section by running a command like this:

readelf -x.note.GNU-stack <file>
If readelf reports that it “has no data to dump”  then the section is missing. Readelf can handle multiple object files and libraries, but it will not recurse into directories. So it may be necessary to create a script to search a complicated build tree. If the annocheck program version 10.80 or later is available, this command can be used to search an entire directory tree:

annocheck --disable-hardened –ignore-unknown –ignore-links \
--size-sec=.note.GNU-stack --size-missing <directory>
Updating assembler source code to create a .note.GNU-stack section just means adding a line like this:

.section  .note.GNU-stack, “”, @progbits
If the assembler code does need an executable stack then the line should looks like this:

.section  .note.GNU-stack, “x”, @progbits
Alternatively linking with the -z no-exec-stack command line option will tell the linker to ignore the missing .note.GNU-stack sections and instead just assume that one was present, but that it was not marked as needing an executable stack. If truly needed the -z execstack option could be used instead, which will also ignore the missing sections, but it will then create an executable stack.

The executable segment warnings
 When loaded into memory, a program is normally split up into different segments. One for code, one for data and maybe some others for various special uses. The segments have attributes such as readable, writable and executable and if they have all three then they are vulnerable to attack. So in such cases the linker will produce one of these warnings:

warning: <file> has a LOAD segment with RWX permissions

This warning indicates that there are one or more vulnerable segments. These segments can be found by running the readelf  program like this:

readelf -lW <file>  
Note: In readelf’s output, the executable flag for segments is labeled as E rather than X, so look for RWE rather than RWX.  

The most common cause of this warning is linking with  a custom linker script, one which does not separate code and data into different segments. So the best solution is to update the script.

The readelf command shown above will show which sections are contained by each segment, so it should be possible to work out how the linker map needs to be updated in order to separate code sections from writable sections. Usually this will involve ensuring that sufficient alignment is used.  For example this script:

SECTIONS
{
  .text : { *(.text) }
  .data : { *(.data) }
}
Is likely to trigger the warning because the code and data are placed next to each other. But this script:

SECTIONS
{
  .text : { *(.text) }
  . = ALIGN (CONSTANT (COMMONPAGESIZE));
  .data : { *(.data) }
}
Should prevent the warning because the ALIGN directive increases the current memory address so that it is a multiple of the provided argument. This will ensure that there is a gap between the .text and .data sections of at least COMMONPAGESIZE bytes, and hence that the linker will be able to place the sections into different memory segments.

Another potential cause is the use of the -z noseparate-code linker command line option. This allows the linker to combine the code and data segments if it can. This does result in a smaller executable, but also a vulnerable one. Using -z noseparate-code is not recommended however unless program size is truly important.

warning: <file> has a TLS segment with execute permission

This is a special form of the RWX segment warning. Some programs can have a special type of data segment called a TLS (Thread Local Store) segment. This is like an ordinary data segment, except that every thread in a program has its own independent copy. Like normal data segments however, TLS segments should never have the execute permission set.

Fixing this warning can be difficult because it depends upon what the threaded code is trying to achieve. In general, though, the process is the same as fixing the warning about a compiler-requested executable stack: find the object file containing an executable TLS section, examine the source code for this file and rewrite as necessary. An executable TLS section can be found using the readelf program like this:

readelf -SW <file> | grep XT
Disabling the warnings
If necessary these warning messages can be disabled via linker command line options. Warning messages about the creation of an executable stack can be disabled with --no-warn-execstack and warnings about executable segments can be disabled --no-warn-rwx-segments.  

The warnings can be reenabled with --warn-execstack and --warn-rwx-segments.

It is also possible to build the linker with either or both of these options disabled by default. This is done by using the --enable-warn-execstack=no and/or --enable-warn-rwx-segments=no configure time options.

Finally, it is also possible to edit the linker source code to set defaults for these warnings based upon the target configuration. There is code at the start of the ld/configure.tgt file which can be used for this purpose. This is currently used by SPARC targets, for example, to disable the RWX segment warning, since such segments are actually required by the SPARC API.

Summary
The new linker warnings are intended to alert developers to some potential security vulnerabilities in their programs. These warnings can be disabled if necessary, but a better course of action would be to correct the issue that is triggering them.
