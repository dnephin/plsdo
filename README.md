# Please Do

Please Do is a tool for automating and standardizing common development tasks.

See [Why not Makefiles?](#why-not-makefiles).

## Usage

Copy `plsdo.sh` into your project anywhere you want. In this example we will use
`.plsdo.sh`.

Create a bash script named `do`:

```
$ touch do; chmod +x do; git add do
```

Start by sourcing `.plsdo.sh`, then write tasks as bash functions.
Call `_plsdo "$@"` at the end of the file.

```sh
#!/usr/bin/env bash

source .plsdo.sh

help[binary]="Build the binary"
binary() {
    go build -o ./dist/app .
}

_plsdo "$@"

```

Finally run the task:

```
$ ./do binary
```

### Settings

Settings may be set in `./do` after sourcing `plsdo.sh`. The list below
shows the default value of settings.

* `_plsdo_max_task_name_width=12` - width used for task names when printing help

The following bash options will be set when `plusdo.sh` is sourced. You may
choose to unset them after sourcing the file.

```sh
set -o errexit -o nounset -o pipefail
```

### Default Tasks

These tasks are provided by `plsdo.sh`.

* `help` - print the help line for all tasks
* `help TASK` - print a detailed help message for the task
* `list` - print a list of all tasks
* `_plsdo_completion` - print `./do` tab completion for $SHELL
* `_plsdo_error` - echo to stderr instead of stdout


## Why not Makefiles?

Many projects use a Makefile with `.PHONY` targets. While this is a common
practice there are some disadvantages to that approach.

One of the primary features of make is the ability to declare prerequisites
for a task. The task may not be invoked if the artifact is more recent than
its dependencies. If you rely heavily on this feature, makefiles are probably
the right choice.

The toolchain of some modern programming languages, such as Go, already handle
this type of caching, removing the need for every project to implement it
themselves.

Projects in those languages may end up with a Makefile that is mostly `.PHONY`
targets, not leveraging that key feature at all.

Makefiles have a number of disavantages as well.

A task to list all targets, or print help for a target is not built in, and
there is no robust solution to add them.

A contributor to your project who needs to add or modify a task must learn the
Makefile syntax. Bash, while maybe not significantly more approachable, is at
least more widely used. It is a more complete language, and is imperative,
making it closer to many other widely used programing languages.

Many sophisticated Makefiles will end up with either embedded bash (requiring
newline escapes on every line, or many calls to bash scripts.

Makefiles do not allow variables to be defined inside of targets, so you end up with a bunch
of unrelated vars defined at the top of a file, far from where they are used.
(TODO: is this necessary, or could they be put closer?)

Bash functions can call other bash functions. The imperative call is
sometimes easier to follow than dependency chains spread out over a file.

When you do have the occasional task that can benefit from the makefile cache,
you can call `make` from bash and reap the benefit, without the makefile being
the primary UI to the project tasks.
