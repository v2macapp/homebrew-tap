cask "v2mac" do
  version "1.8.0"

  on_arm do
    sha256 "844fdff4eda4571c860bf528768cdc5e0f4b95849acf85b38e9f2eae313c5a7a"

    url "https://github.com/v2macapp/v2mac/releases/download/v#{version}/V2Mac-#{version}.dmg"
  end
  # Local validation hash; release CI replaces both hashes before this branch is published.
  on_intel do
    sha256 "dfc072200c43eed7c3d926e75fbd7febc43f5a3dffed7275c6653619e515dcdb"

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
