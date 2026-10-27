class Container-structure-test < Formula
  desc "Validate the structure of your container images"
  homepage "https://example.org/container-structure-test"
  version "1.22.1"
  url "http://127.0.0.1:8080/brew/bottles/container-structure-test--1.22.1.loongarch64.bottle.tar.gz"
  sha256 "08074419034cbe1013188868ae0cf6c07f4af0453053631b5a673399dc763295"

  def install
    bin.install "container-structure-test"
  end

  test do
    system "#{bin}/container-structure-test"
  end
end
