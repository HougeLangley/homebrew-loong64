class Pueue < Formula
  desc "Command-line tool for managing long-running shell commands"
  homepage "https://github.com/Nukesor/pueue"
  url "https://github.com/Nukesor/pueue/archive/refs/tags/v4.0.4.tar.gz"
  sha256 "sha256_placeholder"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"pueue", "--version"
  end
end
