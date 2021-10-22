# The platform/arch combinations that we support.
$targets = {
 :macos_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.2/optic_capture-v0.2.2-x86_64-apple-darwin.tar.gz",
   :sha => "3507b12e981bea5d5f5ccf948f01b381b9a8092db0cd790492bd869e2d65b1af",
   :binary => "optic_capture-x86_64-apple-darwin" },

 :macos_arm => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.2/optic_capture-v0.2.2-aarch64-apple-darwin.tar.gz",
   :sha => "a631210de95299e1bebcc9acab470be965e6e797862c6fd1498124e4241b114a",
   :binary => "optic_capture-aarch64-apple-darwin" },

 :linux_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.2/optic_capture-v0.2.2-x86_64-unknown-linux-musl.tar.gz",
   :sha => "47293af3c45e73426d239dee240c91b84b328f783d3da00af54d029222f1fd45",
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
    assert_match "Optic Capture 0.2.2", shell_output("#{bin}/optic_capture --version")
  end
end
