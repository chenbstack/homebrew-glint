cask "glint" do
  version "0.0.1"
  sha256 "16ad50e37e38d474cd8ac7c256701925f6e1aa1c9fe259878af5b0f0415c7ee1"

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
