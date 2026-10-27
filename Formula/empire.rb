class Empire < Formula
  desc "A PaaS built on top of Amazon EC2 Container Service (ECS)"
  homepage "https://example.org/empire"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/empire--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "655ef2cc7853983f037afa3795d41e4fe57437eabf2c49c41c6b0af35c8571c3"

  def install
    bin.install "empire"
  end

  test do
    system "#{bin}/empire"
  end
end
