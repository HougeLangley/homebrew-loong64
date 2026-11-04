class Cowsay < Formula
  desc "Apjanke's fork of the classic cowsay project"
  homepage "https://cowsay.diamonds"
  url "https://github.com/cowsay-org/cowsay/archive/refs/tags/v3.8.4.tar.gz"
  sha256 "c15bc10712835d3a9bcda780dc9453362567bf48d1185905dc7ef2334d79aadd"
  license "GPL-3.0-only"
  head "https://github.com/cowsay-org/cowsay.git", branch: "main"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8a5bc0ff4abb95987bca4739dbf6cc52c536adb514e7389435fa0a56143a3c9d"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    output = shell_output("#{bin}/cowsay moo")
    assert_match "moo", output  # bubble
    assert_match "^__^", output # cow
  end
end
