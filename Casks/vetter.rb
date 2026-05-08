cask "vetter" do
  version "0.2.1"
  sha256 "dd46cba4155d46145aefa6d6b386e9df47c31da23f45607a7bdce659a046070e"

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
