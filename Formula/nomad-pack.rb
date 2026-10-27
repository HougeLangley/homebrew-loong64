class Nomad-pack < Formula
  desc "Templating and packaging tool used with HashiCorp Nomad"
  homepage "https://example.org/nomad-pack"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/nomad-pack--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "70bc3e68d83ac5fec4ba70ae23035de1c4bf5819a8db4b7e54f3dad4dd96febf"

  def install
    bin.install "nomad-pack"
  end

  test do
    system "#{bin}/nomad-pack"
  end
end
