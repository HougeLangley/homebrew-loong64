class Klog < Formula
  desc "Command-line tool for time tracking in a human-readable, plain-text file format."
  homepage "https://example.org/klog"
  version "7.2"
  url "http://127.0.0.1:8080/brew/bottles/klog--7.2.loongarch64.bottle.tar.gz"
  sha256 "be6cb0e7184e7b0fd3d3307156f053fa068add237cbad47c392abb03e7bf5ca0"

  def install
    bin.install "klog"
  end

  test do
    system "#{bin}/klog"
  end
end
