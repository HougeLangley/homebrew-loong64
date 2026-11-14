class Pie < Formula
  desc "PHP Installer for Extensions"
  homepage "https://github.com/php/pie"
  url "https://github.com/php/pie/releases/download/1.5.3/pie.phar"
  sha256 "34a1315073b6089d4cdf4cc5a8295ecc6d36cfde683ef785582f7da0d74f127b"
  license "BSD-3-Clause"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d3788c63b87aa5666c49ac3a38c0f37c62211e84ed58c464f334b0c090738197"
  end

  depends_on "pkgconf" => :test
  depends_on "re2c" => :test
  depends_on "php"

  allow_network_access! :test

  def install
    bin.install "pie.phar" => "pie"
    generate_completions_from_executable("php", bin/"pie", "completion")
  end

  test do
    system bin/"pie", "build", "apcu/apcu"
  end
end
