cask "v2mac" do
  version "1.11.0"

  on_arm do
    sha256 "16ce24916571dbc4033d38cb892afb2059671753d695d0c9403fe262b7170de4"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  end
  on_intel do
    sha256 "1e5dfda0c1b639d4637da418b2a73dac7414187340a0615017499926581d61f2"

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
