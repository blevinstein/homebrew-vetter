# homebrew-vetter

Homebrew tap for [vetter](https://github.com/blevinstein/vetter) — a
local security gate that sits between an LLM coding agent and
"dangerous" CLI commands.

The repo's only contents are
[`Casks/vetter.rb`](Casks/vetter.rb), a single
[Cask](https://docs.brew.sh/Cask-Cookbook) that installs `Vetter.app`
to `/Applications/` and symlinks the bundled `vet` CLI into
`$(brew --prefix)/bin`.

## Install

```sh
brew tap blevinstein/vetter
brew install --cask vetter
open /Applications/Vetter.app                  # first launch grants notification permission
vet curl https://example.com/                  # `vet` is on PATH via the cask `binary` stanza
```

`brew uninstall --cask vetter` quits the running daemon
(`quit: "dev.vetter.daemon"`) and removes the bundle.
`brew uninstall --cask --zap vetter` additionally clears `~/.vet`
(allowlist) and `~/Library/Logs/vetter` (audit log) — the
user-data paths the daemon writes to.

## How releases land here

Cask updates are produced by the upstream repo's release pipeline
(see [`tools/release.sh`](https://github.com/blevinstein/vetter/blob/main/tools/release.sh)
and [`plans/Release.md`](https://github.com/blevinstein/vetter/blob/main/plans/Release.md)
in `blevinstein/vetter`). The flow is:

1. A maintainer cuts a tag (`git tag v0.1.0`) on `blevinstein/vetter`.
2. `tools/release.sh` builds a universal Mach-O, signs it with the
   project's Developer ID, notarises with Apple, staples the
   ticket, and prints the new `version` + `sha256` lines.
3. Those two lines are pasted into [`Casks/vetter.rb`](Casks/vetter.rb)
   here and pushed.
4. The release zip is attached to the GitHub Release on
   `blevinstein/vetter`, so the cask `url` resolves.

Don't open PRs against this repo to bump the cask manually — the
sha256 has to match a release artifact that only `tools/release.sh`
can produce.

## Cask design notes

- **Single cask, both binaries.** `Vetter.app` is the only artifact.
  The cask's `binary` stanza symlinks the bundled `vet` CLI into
  `$(brew --prefix)/bin`, so users get the daemon and the CLI with
  one `brew install`.
- **`quit:` matches `CFBundleIdentifier`.** `dev.vetter.daemon` is
  the bundle ID set in vetter's `vetterd/resources/Info.plist.template`;
  Homebrew's `quit:` posts an Apple Event so the daemon can shut
  down cleanly (socket + pidfile removal) before the bundle is
  deleted.
- **`zap`** covers the user-data paths the daemon writes to
  (`~/.vet/allowlist.yaml`, `~/Library/Logs/vetter/audit.log`). It
  is opt-in (`brew uninstall --cask --zap vetter`) per Homebrew
  convention; the default uninstall preserves user data.
- **No `launchd` plist.** Vetter is a menu-bar app, not a launchd
  job. The user opens `Vetter.app` once after install (Spotlight,
  Finder, or `open /Applications/Vetter.app`); macOS keeps it alive
  via Launch Services after that.

## Issues / contributions

File issues, feature requests, and bugs upstream at
[blevinstein/vetter](https://github.com/blevinstein/vetter/issues).
Bug reports against this tap repo specifically should be limited to
problems with the cask itself (install fails, uninstall leaves
artifacts, zap path wrong, etc.).
