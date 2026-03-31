class Dust < Formula
  desc "More intuitive version of du in rust"
  homepage "https://github.com/bootandy/dust"
  url "https://github.com/bootandy/dust/archive/refs/tags/v1.2.4.tar.gz"
  sha256 "f960c95dd0137f62822c1539ff5cd426a5184c42a6e23ba8d71b522e7031f68e"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"dust", "--version"
  end
end
