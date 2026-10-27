class Aurora < Formula
  desc "Beanstalkd queue server console"
  homepage "https://example.org/aurora"
  version "2.2"
  url "http://127.0.0.1:8080/brew/bottles/aurora--2.2.loongarch64.bottle.tar.gz"
  sha256 "8bb861e0932777e4729a22c908ab54149d7d8570d95c1157c289ecc3c571639a"

  def install
    bin.install "aurora"
  end

  test do
    system "#{bin}/aurora"
  end
end
