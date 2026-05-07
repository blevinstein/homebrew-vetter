cask "vetter" do
  version "0.2.0"
  sha256 "bd0d0849a52cd1eacea1e7f32d35e470da0430e4abb6b554178fb89375c89323"

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
