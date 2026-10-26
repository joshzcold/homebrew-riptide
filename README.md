# riptide for Homebrew

A [Homebrew](https://brew.sh) tap for [riptide](https://github.com/joshzcold/riptide), a keyboard-driven web browser on CEF.

```sh
brew install --cask joshzcold/riptide/riptide
```

It installs `riptide.app` in Applications and a `riptide` command. The macOS build is experimental: it needs macOS 12 or later, on Apple silicon or Intel, and hasn't been used much by hand yet. See [Installing](https://joshzcold.github.io/riptide/guide/installing.html#macos-experimental).

riptide is signed ad hoc but not notarized by Apple, so the cask clears the download's quarantine flag after installing; otherwise macOS would refuse to open it. Each update has a new signature, so macOS may ask again for the camera, microphone and keychain.

`Casks/riptide.rb` is generated from `.github/riptide.rb.in` by the [update workflow](.github/workflows/update.yml), which follows riptide's latest release. Report problems at [joshzcold/riptide](https://github.com/joshzcold/riptide/issues).
