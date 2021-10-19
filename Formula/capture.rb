class Capture < Formula
  desc "Optic Capture CLI"
  homepage "https://github.com/opticdev/homebrew-capture"
  url "https://s3.amazonaws.com/optic-packages/dists/optic_capture/v0.2.0/optic_capture-v0.2.0-x86_64-apple-darwin.tar.gz"
  sha256 "ea4d43b793022f14e3daaaca2b1148e9cb409d27c268db521fcc4ea5e2a8f3a0"
  license "MIT"

  def install
    bin.install "optic_capture-x86_64-apple-darwin" => "optic_capture"
  end

  test do
    assert_match "Optic Capture", shell_output("#{bin}/optic_capture --version | awk '{print $1\" \"$2}'")
  end
end
