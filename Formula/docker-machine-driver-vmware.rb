class Docker-machine-driver-vmware < Formula
  desc "VMware Fusion & Workstation docker-machine driver"
  homepage "https://example.org/docker-machine-driver-vmware"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/docker-machine-driver-vmware--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "cd379a42435b5ea3cc8ee2d573fd89401b14ddb141e8c97321dc6256172c2847"

  def install
    bin.install "docker-machine-driver-vmware"
  end

  test do
    system "#{bin}/docker-machine-driver-vmware"
  end
end
