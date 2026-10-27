class Asdf < Formula
  desc "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more"
  homepage "https://example.org/asdf"
  version "0.20.2"
  url "http://127.0.0.1:8080/brew/bottles/asdf--0.20.2.loongarch64.bottle.tar.gz"
  sha256 "397804dde8872aa08619397acbd58a7af7e1f3e8e38b33156af54390ae16af46"

  def install
    bin.install "asdf"
  end

  test do
    system "#{bin}/asdf"
  end
end
