class Hasura-cli < Formula
  desc "Command-Line Interface for Hasura GraphQL Engine"
  homepage "https://example.org/hasura-cli"
  version "2.51.3"
  url "http://127.0.0.1:8080/brew/bottles/hasura-cli--2.51.3.loongarch64.bottle.tar.gz"
  sha256 "3ab8a1de55e81b0514dcc65862803b788c6d6f46af61d233638264ecc9c1ad3e"

  def install
    bin.install "hasura-cli"
  end

  test do
    system "#{bin}/hasura-cli"
  end
end
