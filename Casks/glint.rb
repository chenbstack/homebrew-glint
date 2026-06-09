cask "glint" do
  version "0.0.1"
  sha256 "PLACEHOLDER_SHA256_FILLED_AFTER_RELEASE_BUILDS"

  url "https://github.com/chenbstack/glint/releases/download/v#{version}/Glint-#{version}.dmg"
  name "Glint"
  desc "Polished macOS terminal for AI agents, powered by Ghostty"
  homepage "https://github.com/chenbstack/glint"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Glint.app"

  # Glint isn't Apple-notarized yet — strip the quarantine attribute so
  # Gatekeeper doesn't block the unsigned build at launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Glint.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Glint",
    "~/Library/Caches/app.glint.Glint",
    "~/Library/Preferences/app.glint.Glint.plist",
    "~/Library/Saved Application State/app.glint.Glint.savedState",
  ]
end
