# The platform/arch combinations that we support.
$targets = {
 :macos_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.0/optic_capture-v0.2.0-x86_64-apple-darwin.tar.gz",
   :sha => "ea4d43b793022f14e3daaaca2b1148e9cb409d27c268db521fcc4ea5e2a8f3a0",
   :binary => "optic_capture-x86_64-apple-darwin" },

 :macos_arm => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.0/optic_capture-v0.2.0-aarch64-apple-darwin.tar.gz",
   :sha => "6a39d9d27a86c336227b5b837b95835440edd2ccda8e710b4f4bba9d392b86b1",
   :binary => "optic_capture-aarch64-apple-darwin" },

 :linux_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.0/optic_capture-v0.2.0-x86_64-unknown-linux-musl.tar.gz",
   :sha => "ba736bb92f63c733e2884165237f4bfb639048adb551033dd812d038cab9863c",
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
    assert_match "Optic Capture 0.2.0", shell_output("#{bin}/optic_capture --version")
  end
end
