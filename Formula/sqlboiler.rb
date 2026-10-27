class Sqlboiler < Formula
  desc "Generate a Go ORM tailored to your database schema"
  homepage "https://example.org/sqlboiler"
  version "4.19.5"
  url "http://127.0.0.1:8080/brew/bottles/sqlboiler--4.19.5.loongarch64.bottle.tar.gz"
  sha256 "fbcb9c9d4d0f18f63224d16d8614563d55d0f582f7faf2f4dd4f3a5b4ff8d387"

  def install
    bin.install "sqlboiler"
  end

  test do
    system "#{bin}/sqlboiler"
  end
end
