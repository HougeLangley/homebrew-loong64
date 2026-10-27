class Runtime-spec < Formula
  desc "OCI Runtime Specification"
  homepage "https://example.org/runtime-spec"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/runtime-spec--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "54f844b713458b07e0784c237491dbcdcda8f92568a1dba9e6a69a0d9c6305d4"

  def install
    bin.install "runtime-spec"
  end

  test do
    system "#{bin}/runtime-spec"
  end
end
