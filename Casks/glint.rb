cask "glint" do
  version "0.1.16"
  sha256 "ab85cf26d62796dcf7f01053767d5d2490d56579f0a9c6434aae969f42dcd298"

  url "https://github.com/chenbstack/glint/releases/download/v#{version}/Glint-#{version}.dmg"
  name "Glint"
  desc "Polished macOS terminal for AI agents, powered by Ghostty"
  homepage "https://github.com/chenbstack/glint"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Glint self-updates via Sparkle (including opt-in beta-channel builds),
  # so the installed app routinely runs ahead of the cask's pinned stable
  # version. Without this, `brew upgrade` would clobber a self-updated app
  # with the older pinned dmg — i.e. silently downgrade beta users.
  auto_updates true

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
