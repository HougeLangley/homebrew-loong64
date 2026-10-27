class Buildkite < Formula
  desc "Work with Buildkite from the command-line"
  homepage "https://example.org/buildkite"
  version "3.66.0"
  url "http://127.0.0.1:8080/brew/bottles/buildkite--3.66.0.loongarch64.bottle.tar.gz"
  sha256 "82b772af42639c6c8ac8bf7d53c07074bbcdaaed62afefb9dbb61e7c5e367986"

  def install
    bin.install "buildkite"
  end

  test do
    system "#{bin}/buildkite"
  end
end
