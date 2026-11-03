cask "v2mac" do
  version "1.7.0"
  sha256 "abff2a0ced2aa196a5ca5481298489173f02160c8ab0e21b177e556a97170135"

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
