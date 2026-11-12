cask "v2mac" do
  version "1.11.2"

  on_arm do
    sha256 "02baee7b9771c678a29abd8b95185a5fd97b670eb70bde1356c254a57042a4ff"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  end
  on_intel do
    sha256 "5ddd64d8f28b72c29800219bc91a894a0363b46122275f173f09673eade24e6b"

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
