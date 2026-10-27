class Eksctl < Formula
  desc "The official CLI for Amazon EKS"
  homepage "https://example.org/eksctl"
  version "0.231.0"
  url "http://127.0.0.1:8080/brew/bottles/eksctl--0.231.0.loongarch64.bottle.tar.gz"
  sha256 "54a485b2bc469fca59bb8d353e5a309a771307f32432d38fd00109fe6ed000b4"

  def install
    bin.install "eksctl"
  end

  test do
    system "#{bin}/eksctl"
  end
end
