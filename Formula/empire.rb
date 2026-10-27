class Empire < Formula
  desc "A PaaS built on top of Amazon EC2 Container Service (ECS)"
  homepage "https://example.org/empire"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/empire--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "19788e7db3bfdfe4d7d82f1d891acf19312d56b859f084482855f11e09bdc26c"

  def install
    bin.install "empire"
  end

  test do
    system "#{bin}/empire"
  end
end
