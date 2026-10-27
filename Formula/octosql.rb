class Octosql < Formula
  desc "OctoSQL is a query tool that allows you to join, analyse and transform data from multiple "
  homepage "https://example.org/octosql"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/octosql--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "b03864096a723f545ab76f6e2d2ed0c7b9f920628f6f5ea536c1b32a83a9567c"

  def install
    bin.install "octosql"
  end

  test do
    system "#{bin}/octosql"
  end
end
