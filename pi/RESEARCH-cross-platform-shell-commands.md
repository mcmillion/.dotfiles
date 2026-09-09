# Cross-platform shell commands in Pi

## Finding

Pi does not provide a macOS/Linux compatibility mode or automatically tell the
model which platform-specific command variants to use. Its `bash` tool runs a
non-interactive shell; on Unix it resolves Bash first and falls back to `sh`.
Therefore, an agent cannot safely assume either GNU userland or Bash-only
syntax in another session/host. [Pi shell implementation][pi-shell]

This dotfiles repo targets macOS and Linux. It makes GNU coreutils available on
macOS by adding Homebrew's `coreutils/libexec/gnubin` directory in the
interactive Zsh configuration, but Pi's Bash commands are non-interactive and
do not read `.zshrc`. That interactive PATH normalization is thus not a
reliable guarantee for Pi tool calls. [Repository platform notes][repo-readme]
[Pi shell aliases documentation][pi-aliases]

## Pi-specific options

- Put durable instructions in `AGENTS.md`; Pi loads its global context file and
  the ancestor/current project context files. For a universal policy that
  should apply outside this repo, use `~/.pi/agent/APPEND_SYSTEM.md`. A
  project `.pi/APPEND_SYSTEM.md` is appropriate only when the policy is
  project-specific. [Pi context-file and system-prompt docs][pi-readme]
- `shellPath` chooses a shell executable; `shellCommandPrefix` prepends text to
  every Bash-tool command. Neither detects macOS vs. Linux or makes utilities
  portable. The prefix is most appropriate for small, predictable
  initialization; Pi documents it for alias expansion. [Pi settings][pi-settings]
  [Pi shell aliases][pi-aliases]
- Pinning `shellPath` can remove ambiguity about the interpreter, but it does
  **not** normalize Bash versions (macOS's system Bash is commonly old) or the
  BSD/GNU command differences.

## Recommended agent policy

Add this concise policy to the existing Pi `APPEND_SYSTEM.md` (global), or to
an `AGENTS.md` where it should apply only to a project:

```md
## macOS/Linux command portability
- Target macOS and Linux. Before a platform-specific operation, check
  `uname -s` and branch only on `Darwin` or `Linux`.
- Prefer POSIX `sh` syntax and POSIX utilities for ad-hoc commands.
- Do not assume GNU-specific flags or utilities work on macOS (`sed -i`,
  `date -d`, `readlink -f`, and GNU extensions to `grep`, `find`, or `sort`).
- Use Bash-only syntax only when Bash is explicitly invoked/known available.
  Keep OS-specific branches short and explain the detected platform.
- If a command needs GNU tools, first verify the required command/flag;
  otherwise use a portable alternative or an explicit `g*` command on macOS.
```

`uname -s` is a suitable coarse discriminator here: POSIX specifies the
`-s`/operating-system-name option, but its exact value is implementation
-defined, so do not parse broader `uname` output or rely on it for arbitrary
platform families. [POSIX `uname`][posix-uname]

## Operational recommendation for this setup

1. Start with the prompt policy above. It prevents most silent GNU-vs-BSD
   mistakes and works regardless of whether Pi started Bash or its `sh`
   fallback.
2. Do **not** source the interactive Zsh config using `shellCommandPrefix`:
   Pi executes non-interactive Bash, and a Zsh startup file is not a compatible
   Bash initialization file.
3. If GNU utilities are genuinely required, install/ensure Homebrew coreutils
   on both hosts and use an explicit, verified path or `g`-prefixed binary in
   the small platform-specific branch. Do not depend on the interactive PATH
   mutation being inherited by an agent session.
4. If failures remain, have the agent first report `uname -s`, `command -v
   bash`, and the relevant utility version/help output; that distinguishes an
   interpreter problem from a BSD/GNU utility mismatch.

## Sources

- [Pi README: context files and system prompts][pi-readme]
- [Pi settings: Shell][pi-settings]
- [Pi shell aliases][pi-aliases]
- [Pi source: shell resolution][pi-shell]
- [Pi source: Bash tool execution][pi-bash-tool]
- [POSIX `uname`][posix-uname]
- [GNU Bash manual: POSIX mode][bash-posix]
- [This repository's platform notes][repo-readme]

[pi-readme]: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/README.md#context-files
[pi-settings]: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/settings.md#shell
[pi-aliases]: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/shell-aliases.md
[pi-shell]: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/src/utils/shell.ts
[pi-bash-tool]: https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/src/core/tools/bash.ts
[posix-uname]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/uname.html
[bash-posix]: https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html
[repo-readme]: ../README.md#platform-notes
