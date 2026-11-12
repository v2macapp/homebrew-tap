cask "v2mac" do
  version "1.12.1"

  on_arm do
    sha256 "783dcd75a67f2ac00d62f8a324ddebb3dc7a358b8a6f99d2bcaf71b99f15ed1b"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  end
  on_intel do
    sha256 "75b073891567f6ef3127393edd36a7d5770e244876f08ac06e92e540aa4e93d9"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}-intel.dmg"
  end

  name "V2Mac"
  desc "Menu bar client for Xray-core"
  homepage "https://github.com/v2macapp/v2mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself in place, so `brew upgrade` leaves it alone.
  auto_updates true
  depends_on macos: :sonoma

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
