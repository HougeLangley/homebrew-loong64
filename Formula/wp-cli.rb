class WpCli < Formula
  desc "Command-line interface for WordPress"
  homepage "https://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar"
  sha256 "ce34ddd838f7351d6759068d09793f26755463b4a4610a5a5c0a97b68220d85c"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "548120e8770783981a512a817f61da7e448d98158bc7e2a73feb5147281c13d4"
  end

  depends_on "php"

  # Keg-relocation breaks the formula when it replaces `/usr/local` with a non-default prefix
  on_macos do
    on_intel do
      pour_bottle? only_if: :default_prefix
    end
  end

  allow_network_access! :test

  def install
    bin.install "wp-cli-#{version}.phar" => "wp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wp --version")

    # workaround to fix memory exhaustion error
    # see https://make.wordpress.org/cli/handbook/guides/common-issues/#php-fatal-error-allowed-memory-size-of-999999-bytes-exhausted-tried-to-allocate-99-bytes
    output = shell_output("php -d memory_limit=512M #{bin}/wp core download --path=wptest")
    assert_match "Success: WordPress downloaded.", output
  end
end
