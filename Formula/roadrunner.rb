class Roadrunner < Formula
  desc "🤯 High-performance PHP application server, process manager written in Go and powered with "
  homepage "https://example.org/roadrunner"
  version "3.0.1"
  url "http://127.0.0.1:8080/brew/bottles/roadrunner--3.0.1.loongarch64.bottle.tar.gz"
  sha256 "04bb17133511f58e0fad2f44722562c3ede9ecced4f020e263d2332b93b76ba0"

  def install
    bin.install "roadrunner"
  end

  test do
    system "#{bin}/roadrunner"
  end
end
