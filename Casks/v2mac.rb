cask "v2mac" do
  version "1.11.1"

  on_arm do
    sha256 "9939911fdb1cd537197288e3a3259e9af8c0e49b956339fbd967dc4e66f58844"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  end
  on_intel do
    sha256 "1cd479f382341153eacdd5773bcc9452db975d64f00d6560255cc6586a83c9a9"

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
