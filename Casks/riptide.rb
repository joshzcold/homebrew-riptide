cask "riptide" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.14.2"
  sha256 arm:   "2119f05aa0e1969417286d6ec238094f1fc4f51ef162b6f669ee2f45289674de",
         intel: "1603642ce092818cccf3646c9e6a710a3719e0c8bf8de85e936fd72e1e4a1467"

  url "https://github.com/joshzcold/riptide/releases/download/v#{version}/riptide-#{version}-macos-#{arch}.dmg"
  name "riptide"
  desc "Keyboard-driven web browser with vim-like keys, on CEF"
  homepage "https://joshzcold.github.io/riptide/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "riptide.app"
  # The launcher, not the binary: the binary finds CEF relative to its own path.
  binary "#{appdir}/riptide.app/Contents/Resources/bin/riptide"

  # riptide is signed ad hoc but not notarized, so Gatekeeper would block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/riptide.app"]
  end

  zap trash: [
    "~/.config/riptide",
    "~/Library/Application Support/riptide",
  ]
end
