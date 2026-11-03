cask "v2mac" do
  version "1.7.1"
  sha256 "63b8a25506f3b692f586f479bda697e2624ace889b4448813e1d88a682c13bc9"

  url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  name "V2Mac"
  desc "Menu bar client for Xray-core"
  homepage "https://github.com/v2macapp/v2mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself in place, so `brew upgrade` leaves it alone.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "V2Mac.app"
  binary "V2Mac.app/Contents/Helpers/v2mac"

  # The app is ad-hoc signed and not notarized, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/V2Mac.app"]
  end

  uninstall quit: "io.github.lordversa.v2mac"

  zap trash: [
    "~/Library/Application Support/v2mac",
    "~/Library/Preferences/io.github.lordversa.v2mac.plist",
  ]
end
