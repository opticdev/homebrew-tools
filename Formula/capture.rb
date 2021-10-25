# The platform/arch combinations that we support.
$targets = {
 :macos_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.3/optic_capture-v0.2.3-x86_64-apple-darwin.tar.gz",
   :sha => "be7b78d3c9bb130e50ced0aa482cc8707dcb474e6fe0916aff6b08930c6044a3",
   :binary => "optic_capture-x86_64-apple-darwin" },

 :macos_arm => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.3/optic_capture-v0.2.3-aarch64-apple-darwin.tar.gz",
   :sha => "93da67f8fcf2c9059e6cab37df8c1c903c5bd2e316814b1d5d28a4977c9c5354",
   :binary => "optic_capture-aarch64-apple-darwin" },

 :linux_x86 => {
   :url => "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.3/optic_capture-v0.2.3-x86_64-unknown-linux-musl.tar.gz",
   :sha => "2e03aa43bc98e2162900356bec72a28256bfd48e2b41fc8f3f333460e011582c",
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
    assert_match "Optic Capture 0.2.3", shell_output("#{bin}/optic_capture --version")
  end
end
