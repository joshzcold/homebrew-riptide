cask "riptide" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.16.0"
  sha256 arm:   "4a3e595e6a75e518d932534af8fcf1f759c61a8607ea3947e4dab4a1c3e461a7",
         intel: "19e8ce226155ba5566b457ba07de5a40b6884ed1641291e159296060530c6e3c"

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
