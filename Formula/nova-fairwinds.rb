class Nova-fairwinds < Formula
  desc "Find outdated or deprecated Helm charts running in your cluster"
  homepage "https://example.org/nova-fairwinds"
  version "3.12.2"
  url "http://127.0.0.1:8080/brew/bottles/nova-fairwinds--3.12.2.loongarch64.bottle.tar.gz"
  sha256 "28a20f6e0ee47aa8fbfb2377cf7c619bcc17fd06aa79e90f9b97f3f5ac933959"

  def install
    bin.install "nova-fairwinds"
  end

  test do
    system "#{bin}/nova-fairwinds"
  end
end
