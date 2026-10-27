class Smartcommit < Formula
  desc "Enforce the habit of self-documenting code through better commit messages."
  homepage "https://example.org/smartcommit"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/smartcommit--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "6b7292bfc1f2decb759162798e19b6788d092b307a93f97eba596e488aded0a4"

  def install
    bin.install "smartcommit"
  end

  test do
    system "#{bin}/smartcommit"
  end
end
