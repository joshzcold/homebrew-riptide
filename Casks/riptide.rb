cask "riptide" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.19.0"
  sha256 arm:   "e7e549f62ebbc9d062cfe5da923b9531ec54a4945bdcbdceea449cae2ac7c222",
         intel: "2c0acebd5e35d330eb08a6ad00d77389e3a6d1371e46ef6aaefb0822d7471ab1"

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
