class Kubent < Formula
  desc "Easily check your clusters for use of deprecated APIs"
  homepage "https://example.org/kubent"
  version "0.7.3"
  url "http://127.0.0.1:8080/brew/bottles/kubent--0.7.3.loongarch64.bottle.tar.gz"
  sha256 "7e6537559b92b369b4cac3a8f263159c1f46f779a2408397bfaeced266aa8850"

  def install
    bin.install "kubent"
  end

  test do
    system "#{bin}/kubent"
  end
end
