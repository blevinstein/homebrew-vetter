cask "vetter" do
  version "0.2.2"
  sha256 "f531705e0878fdcae99a99f75c8fe665f70d1374700be584954b00c41a05c45c"

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
