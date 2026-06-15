cask "vetter" do
  version "0.2.3"
  sha256 "3e3472a0c81d95f35cefb86a013d27d1e1c88ca7b241679d491c2199dcccddc6"

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
