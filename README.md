# PlsDo

Pl[ea]s[e ]Do is a tool for automating software development tasks.

See [Why not Makefiles?](#why-not-makefiles)

## Usage

Copy `plsdo.sh` into your project anywhere you want. In this example we will use
`.plsdo.sh`.

Create a bash script named `do`:

```
$ touch do; chmod +x do; git add do
```

Start by sourcing `.plsdo.sh`, then write tasks as bash functions.
Call `_plsdo_run "$@"` at the end of the file.

```sh
#!/usr/bin/env bash

source .plsdo.sh

help[binary]="Build the binary"
binary() {
    go build -o ./dist/app .
}

_plsdo_run "$@"

```

Finally run the task:

```
$ ./do binary
```

## Documentation

### Writing Tasks

A task is a regular bash function. Tasks may call other tasks, they are bash functions.
Tasks may be put into multiple files and sourced from `./do` after `.plsdo.sh`.

To debug a task run `bash -x ./do TASK`.

### Default Tasks

These tasks are provided by `plsdo.sh`.

* `help` - print the help line for all tasks
* `help TASK` - print a detailed help message for the task
* `list` - print a list of all tasks
* `_plsdo_completion` - print `./do` tab completion for $SHELL
* `_plsdo_error` - echo to stderr instead of stdout


### Task `help` and `list`

You may add a help message for a task by adding to the `help` associative
array, using the function name as the key, and the help text as the value.
The first line will be printed when viewing the help for all tasks (`./do help`),
and the full multiline help will be printed when asking for detailed help with
(`./do help TASK`).

The help message should explain what the task does, and include details about
the arguments, environment variables, binaries, and exit codes used by the task.

Tasks (or functions) which start with underscore will not appear in `help` or
`list`.

Set the environment variable `banner` to a value to have it printed before any
tasks in the `help` message.

### Settings

Settings are set as environment variables in `./do` before calling `_plsdo "$@"`. The list below
shows the default value of all settings.

* `_plsdo_help_task_name_width=12` - width of  the task name column printed by
  help. Set to a larger value if you have tasks with longer names.

The following bash options will be set when `plsdo.sh` is sourced. You may
choose to unset them after sourcing the file.

```sh
set -o errexit -o nounset -o pipefail
```

## Why not Makefiles?

Make is a powerful and widely used build automation tool. For decades, it has been an
indispensable tool for compiling software.

Make is often used to automate development tasks, such as building a binary. 

X: because it is able to avoid doing work that does not need to be repeated.

X: The automation of development tasks continues to be as important as ever,
however, the task of avoiding unnecessary work has been taken on by new tools.
The compiler or interpreter for many modern programming languages handles
the caching of build artifacts, removing the need for it to be handled by Make.

C: If your project relies heavily on the feature, makefiles are probably
the right choice.

X: Projects written in those languages often still use a Makefile to automate
tasks, by using mostly `.PHONY` targets.

X: Make ends up becoming one of the primary CLIs for working with a software
project, and yet perhaps surprisingly is not well suited to solve that problem.

One of the most essential features of a CLI is to get usage and help
documentation for the available commands. Listing all the commands, tab
completion, and support for passing arguments to commands is also quite helpful.

Not only does Make not provide these common features, solutions to provide them
are unintuitive and not robust.

As a project grows and gets more sophisticated, a Makefile often starts to 
include inlined, or run, bash scripts. Often one way or another
bash is being used to handle logic that can't be well expressed by the
Makefile.

Bash, on the other hand, can provide all those coveted features of a CLI,
and many of the use cases handled by Make, in under 100 lines.

Occasionally a project may have one or two tasks that would benefit from the
features of Make. In those running `make` from Bash gives you all the
benefits of both.
