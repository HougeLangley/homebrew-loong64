class Govc < Formula
  desc "Command-line tool for VMware vSphere"
  homepage "https://example.org/govc"
  version "0.56.2"
  url "http://127.0.0.1:8080/brew/bottles/govc--0.56.2.loongarch64.bottle.tar.gz"
  sha256 "11e063b6330e15e2f55d7692e2030cad66a941826c615a2afe4e30fc6d4615eb"

  def install
    bin.install "govc"
  end

  test do
    system "#{bin}/govc"
  end
end
