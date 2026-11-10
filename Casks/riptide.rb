cask "riptide" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.21.0"
  sha256 arm:   "4c87b6d6b6ac1ef8fad9338a3836f86449ecacd539459af89be8f8c899e1c012",
         intel: "9a712f9887da90b04db2b4a16f65600d03ffa79ac05ede2f024fb0d6cc139883"

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
