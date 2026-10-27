class Wait4x < Formula
  desc "Wait4X allows you to wait for a port or a service to enter the requested state."
  homepage "https://example.org/wait4x"
  version "3.7.3"
  url "http://127.0.0.1:8080/brew/bottles/wait4x--3.7.3.loongarch64.bottle.tar.gz"
  sha256 "f7e044a2d7cc209599beda3dace7b728f375f10b622dabda91195c24e774d9c1"

  def install
    bin.install "wait4x"
  end

  test do
    system "#{bin}/wait4x"
  end
end
