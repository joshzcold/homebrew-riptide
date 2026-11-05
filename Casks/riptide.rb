cask "riptide" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.17.0"
  sha256 arm:   "8277ae6c66f17990e8b086f892c9bb6a17c788f35ba130040357cf08ae7bc9fc",
         intel: "aa6d3f0ab2c2b8165b77fa7c8dd97ed1486e71b160004223fc4032bb778f6d8d"

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
