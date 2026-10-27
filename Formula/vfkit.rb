class Vfkit < Formula
  desc "Command-line hypervisor using Apple's Virtualization Framework"
  homepage "https://example.org/vfkit"
  version "0.6.4"
  url "http://127.0.0.1:8080/brew/bottles/vfkit--0.6.4.loongarch64.bottle.tar.gz"
  sha256 "53945fe54495a66084bf8c4a35f77b965f0468c478795e2815d4b250e10581f5"

  def install
    bin.install "vfkit"
  end

  test do
    system "#{bin}/vfkit"
  end
end
