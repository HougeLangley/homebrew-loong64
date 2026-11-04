class ApibuilderCli < Formula
  desc "Command-line interface to generate clients for api builder"
  homepage "https://www.apibuilder.io"
  url "https://github.com/apicollective/apibuilder-cli/archive/refs/tags/0.2.4.tar.gz"
  sha256 "80291a48e1637c24ac691b5e56061264b31342d35a560a05a6fcabfb847a46fd"
  license "MIT"


  uses_from_macos "ruby"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "653add821883ecc74ba0a84c2598820c8ab6cab42d6fbbcca342b13e28c4d6ed"
  end

  def install
    system "./install.sh", prefix
  end

  test do
    (testpath/"config").write <<~EOS
      [default]
      token = abcd1234
    EOS

    assert_match "Profile default:",
                 shell_output("#{bin}/read-config --path config")
    assert_match "Could not find apibuilder configuration directory",
                 shell_output("#{bin}/apibuilder", 1)
  end
end
