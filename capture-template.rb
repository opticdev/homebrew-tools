class Capture < Formula
  desc "Optic Capture CLI"
  homepage "https://github.com/opticdev/homebrew-capture"
  url "{URL}"
  sha256 "{SHASUM}"
  license "MIT"

  def install
    bin.install "optic_capture-x86_64-apple-darwin" => "optic_capture"
  end

  test do
    assert_match "Optic Capture", shell_output("#{bin}/optic_capture --version | awk '{print $1\" \"$2}'")
  end
end
