class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://example.org/starship"
  version "1.27.0"
  url "http://127.0.0.1:8080/brew/bottles/starship--1.27.0.loongarch64.bottle.tar.gz"
  sha256 "5cc3e8f292e7553060fc61837aeffa162da253b3be81bb81287e301dfd31d063"

  def install
    bin.install "starship"
  end

  test do
    system "#{bin}/starship"
  end
end
