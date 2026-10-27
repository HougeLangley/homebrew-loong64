class Cilium-cli < Formula
  desc "CLI to install, manage & troubleshoot Kubernetes clusters running Cilium"
  homepage "https://example.org/cilium-cli"
  version "0.20.1"
  url "http://127.0.0.1:8080/brew/bottles/cilium-cli--0.20.1.loongarch64.bottle.tar.gz"
  sha256 "866145ed56b301637604b7224997c54dc827286c3777329f6e8c41db8f971fb1"

  def install
    bin.install "cilium-cli"
  end

  test do
    system "#{bin}/cilium-cli"
  end
end
