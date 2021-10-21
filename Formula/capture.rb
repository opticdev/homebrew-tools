# The platform/arch combinations that we support.
$targets = {
 :macos_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.1/optic_capture-v0.2.1-x86_64-apple-darwin.tar.gz",
   :sha => "454629c853ec3c6c48bcc21b4b3d9000adcd671aa9e83f8e8c5b2c23c082fc01",
   :binary => "optic_capture-x86_64-apple-darwin" },

 :macos_arm => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.1/optic_capture-v0.2.1-aarch64-apple-darwin.tar.gz",
   :sha => "2ebe953b9aa6db539d5d2ae5a3adc55f89851ff62f916f93b787965acef2e463",
   :binary => "optic_capture-aarch64-apple-darwin" },

 :linux_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.1/optic_capture-v0.2.1-x86_64-unknown-linux-musl.tar.gz",
   :sha => "acbd0933e739ed4f444c5c796ebd357eac7160df13ebebeaac41fc53dfb25599",
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
    assert_match "Optic Capture 0.2.1", shell_output("#{bin}/optic_capture --version")
  end
end
