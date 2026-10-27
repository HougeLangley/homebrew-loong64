class Ifacemaker < Formula
  desc "Generate interfaces from structure methods"
  homepage "https://example.org/ifacemaker"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/ifacemaker--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "d354b21f3fd308adb1ccf41ac2ab5be31ea5901036638bad25556dc8cb12d811"

  def install
    bin.install "ifacemaker"
  end

  test do
    system "#{bin}/ifacemaker"
  end
end
