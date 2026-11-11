class Phpbrew < Formula
  desc "Brew & manage PHP versions in pure PHP at HOME"
  homepage "https://phpbrew.github.io/phpbrew"
  url "https://github.com/phpbrew/phpbrew/releases/download/2.2.0/phpbrew.phar"
  sha256 "3247b8438888827d068542b2891392e3beffebe122f4955251fa4f9efa0da03d"
  license "MIT"
  revision 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b98b803db824ca46350a74cac67a6d3445e39b090d400a6914b3ec64ee3ab9f9"
  end

  depends_on "php@8.4"

  # Keg-relocation breaks the formula when it replaces `/usr/local` with a non-default prefix
  on_macos do
    on_intel do
      pour_bottle? only_if: :default_prefix
    end
  end

  allow_network_access! :test

  def install
    libexec.install "phpbrew.phar" => "phpbrew"
    (bin/"phpbrew").write <<~PHP
      #!#{formula_opt_bin("php@8.4")}/php
      <?php require '#{libexec}/phpbrew';
    PHP
  end

  test do
    system bin/"phpbrew", "init"
    assert_match "8.5", shell_output("#{bin}/phpbrew known")
  end
end
