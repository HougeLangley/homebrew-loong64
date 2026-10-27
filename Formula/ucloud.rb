class Ucloud < Formula
  desc "Official tool for managing UCloud services"
  homepage "https://example.org/ucloud"
  version "0.3.10"
  url "http://127.0.0.1:8080/brew/bottles/ucloud--0.3.10.loongarch64.bottle.tar.gz"
  sha256 "f815b9ef7007d6f91e8f7989e7ed81d38518208af921ebe5d07e44785d4000be"

  def install
    bin.install "ucloud"
  end

  test do
    system "#{bin}/ucloud"
  end
end
