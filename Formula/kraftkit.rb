class Kraftkit < Formula
  desc "Build and use highly customized and ultra-lightweight unikernel VMs"
  homepage "https://example.org/kraftkit"
  version "0.12.16"
  url "http://127.0.0.1:8080/brew/bottles/kraftkit--0.12.16.loongarch64.bottle.tar.gz"
  sha256 "42b7a82aa5aff1a92842ff612ed66867020a3e240c5b38a3899148c94548344d"

  def install
    bin.install "kraftkit"
  end

  test do
    system "#{bin}/kraftkit"
  end
end
