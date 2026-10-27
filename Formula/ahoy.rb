class Ahoy < Formula
  desc "Create shareable, self-documenting command-line tools from simple YAML files. Easily wrap "
  homepage "https://example.org/ahoy"
  version "3.0.2"
  url "http://127.0.0.1:8080/brew/bottles/ahoy--3.0.2.loongarch64.bottle.tar.gz"
  sha256 "d5b2110cd21c17f69f880fbc7189efc0b91b539c38168d9c9cadd25eeac20cd5"

  def install
    bin.install "ahoy"
  end

  test do
    system "#{bin}/ahoy"
  end
end
