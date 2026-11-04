class Picoruby < Formula
  desc "Smallest Ruby implementation for microcontrollers"
  homepage "https://picoruby.org"
  url "https://github.com/picoruby/picoruby.git",
      tag:      "4.0.5",
      revision: "604666ec366bd9c597756e3d671bfa4c378f165d"
  license "MIT"
  head "https://github.com/picoruby/picoruby.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e5313c936f3c96e1e24426076237ce659e750194c7eb4275921fac8df73c85e8"
  end

  depends_on "ruby" => :build # for numbered block parameter `_1'
  depends_on "openssl@4"

  deny_network_access!

  def install
    ENV["MRUBY_CONFIG"] = buildpath/"build_config/default.rb"
    system "rake"
    bin.install Dir["build/host/bin/*"]
    lib.install Dir["build/host/lib/*"]
    include.install Dir["include/*"]
  end

  test do
    output = shell_output("#{bin}/picoruby -e \"puts 'Hello, PicoRuby!'\"")
    assert_match "Hello, PicoRuby!", output
  end
end
