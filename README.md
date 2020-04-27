# Pl〈ea〉s〈e 〉Do

A tool for automating software development tasks.

[Why not Makefiles?](#why-not-makefiles)

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

A task is a regular bash function. A help entry may be added for a task by populating
the `help` array, using the name of the task as a key.

As with any bash function, a task may call other functions, read environment variables
or positional args, and return with an exit code.

To debug a task run `bash -x ./do TASK`.

### Default Tasks

Default tasks are ones provided by `plsdo.sh`.

* `help` - Print the list of tasks, with a single line of help for each. Run
  `help TASK` to print detailed help message for a task.
* `list` - Print the list of tasks one per line. Used by tab completion.
* `_plsdo_completion` - Print `./do` tab completion for $SHELL.


### Task `help` and `list`

You may add a help message for a task by adding to the `help` associative
array, using the function name as the key, and the help text as the value.
The first line should be short, similar to a git commit message. It will be
printed when viewing the help for all tasks (`./do help`).
The full multiline help will be printed when asking for detailed help with
(`./do help TASK`).

The help message should explain what the task does, and include details about
the arguments, environment variables, binaries, and exit codes used by the task.

Helper functions should start with underscore so that they do not appear in `help` or
`list`.

Set the environment variable `banner` to a value to have it printed before any
tasks in the `help` message.

### Settings

Settings are set as environment variables in `./do` before calling `_plsdo "$@"`. The list below
shows the default value of all settings.

* `_plsdo_help_task_name_width=12` - width of the task name column printed by
  help. Set to a larger value if you have tasks with longer names.

The following bash options will be set when `plsdo.sh` is sourced. You may
choose to unset them after sourcing the file.

```sh
set -o errexit -o nounset -o pipefail
```

## Why not Makefiles?

Make is a powerful and widely used build automation tool. For decades, it has been an
indispensable tool for compiling software. Make is often chosen because of its
ability to avoid doing work that does not need to be repeated.

The automation of development tasks continues to be as important as ever.
However, the task of avoiding unnecessary work has been taken on by new tools.
The compiler or interpreter for many modern programming languages handles
the caching and reuse of build artifacts, removing the need for it to be handled by Make.

Projects written in those languages often still use a Makefile to automate
development tasks, by using mostly `.PHONY` targets. Make has become a common CLIs for
working with a software project. Surprisingly it is not well suited to solve that problem.

One of the most essential features of a CLI is to provide usage
documentation for available commands. Listing commands, tab
completion, and support for positional arguments are also helpful features of a
CLI. Make does not provide these features, and solutions to provide them
from a Makefile are often unreliable.

As a project grows and becomes more sophisticated, a Makefile often starts to
include inline bash, or executes bash scripts. Bash is being used to handle logic
that can not be expressed by the native Makefile syntax. Bash, a more general
purpose language, is quite capable of providing all the essential features of a CLI
and many of the use cases handled by Make, in under 100 lines.

Occasionally a project may have one or two tasks that would benefit from the
features of Make. In those cases, running `make` from a Bash script gives you all the
benefits of both tools.
