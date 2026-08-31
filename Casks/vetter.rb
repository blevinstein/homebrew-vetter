cask "vetter" do
  version "0.2.4"
  sha256 "46ae453d6d5a4ab57e3a770a45c91ac68ff895d964ff9059eb7df32e19a634d7"

  url "https://github.com/blevinstein/vetter/releases/download/v#{version}/Vetter-#{version}.zip"
  name "Vetter"
  desc "Local security gate between LLM coding agents and dangerous CLI commands"
  homepage "https://github.com/blevinstein/vetter"

  depends_on macos: ">= :big_sur"

  app "Vetter.app"
  binary "#{appdir}/Vetter.app/Contents/MacOS/vet"

  uninstall quit: "dev.vetter.daemon"

  zap trash: [
    "~/.vet",
    "~/Library/Logs/vetter",
  ]
end
