class Netfetch < Formula
  desc "K8s tool to scan clusters for network policies and unprotected workloads"
  homepage "https://example.org/netfetch"
  version "0.5.4"
  url "http://127.0.0.1:8080/brew/bottles/netfetch--0.5.4.loongarch64.bottle.tar.gz"
  sha256 "f6abc72bbc80e5a6f064c3d1f9298e5f543a74ff3ed3afcb7ba31663156c4319"

  def install
    bin.install "netfetch"
  end

  test do
    system "#{bin}/netfetch"
  end
end
