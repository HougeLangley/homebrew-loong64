class Eksctl < Formula
  desc "The official CLI for Amazon EKS"
  homepage "https://example.org/eksctl"
  version "0.231.0"
  url "http://127.0.0.1:8080/brew/bottles/eksctl--0.231.0.loongarch64.bottle.tar.gz"
  sha256 "4927024fc9e59c157f9e1a521a495dfdf1bb937cfcf06b5c148399eecd59761d"

  def install
    bin.install "eksctl"
  end

  test do
    system "#{bin}/eksctl"
  end
end
