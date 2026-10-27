class Kool < Formula
  desc "Web apps development with containers made easy"
  homepage "https://example.org/kool"
  version "3.7.0"
  url "http://127.0.0.1:8080/brew/bottles/kool--3.7.0.loongarch64.bottle.tar.gz"
  sha256 "eae7ca33dcfc39c5465d03a905f37d2100cd476a4e00c329c187ef014d983f07"

  def install
    bin.install "kool"
  end

  test do
    system "#{bin}/kool"
  end
end
