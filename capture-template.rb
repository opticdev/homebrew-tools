# The platform/arch combinations that we support.
$targets = {
 :macos_x86 => {
   :url => "{URL_MACOS_x86}",
   :sha => "{SHASUM_MACOS_x86}",
   :binary => "optic_capture-x86_64-apple-darwin" },

 :macos_arm => {
   :url => "{URL_MACOS_ARM}",
   :sha => "{SHASUM_MACOS_ARM}",
   :binary => "optic_capture-aarch64-apple-darwin" },

 :linux_x86 => {
   :url => "{URL_LINUX_x86}",
   :sha => "{SHASUM_LINUX_x86}",
   :binary => "optic_capture-x86_64-unknown-linux-musl" },
}

class Capture < Formula
  desc "Optic Capture CLI"
  homepage "https://github.com/opticdev/homebrew-capture"
  license "MIT"

  # Note: target is a class variables, since we are extending Formula and must
  # follow its expectations (i.e. no constructor and no instance variables)
  @@target = $targets[:macos_x86]

  on_macos do
    @@target = $targets[:macos_x86]
    @@target = $targets[:macos_arm] if Hardware::CPU.arm?
  end

  on_linux do
    @@target = $targets[:linux_x86]
  end


  url @@target[:url]
  sha256 @@target[:sha] 

  def install
    bin.install @@target[:binary] => "optic_capture"
  end

  test do
    assert_match "Optic Capture {VERSION}", shell_output("#{bin}/optic_capture --version")
  end
end
