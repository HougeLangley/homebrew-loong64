class Radamsa < Formula
  desc "Test case generator for robustness testing (a.k.a. a \"fuzzer\")"
  homepage "https://gitlab.com/akihe/radamsa"
  url "https://gitlab.com/akihe/radamsa/-/archive/v0.7/radamsa-v0.7.tar.gz"
  sha256 "d9a6981be276cd8dfc02a701829631c5a882451f32c202b73664068d56f622a2"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bc9f610128bdcb1cf1d98793e4e16b2bc02fcb02f1a2496eb6e33efacd7d5721"
  end


  # https://gitlab.com/akihe/radamsa/-/blob/v#{version}/Makefile?ref_type=tags#L7
  resource "ol.c" do
    url "https://haltp.org/files/ol-0.2.2.c.gz"
    version "0.2.2"
    sha256 "fca85dae36910108598d8a4a244df7a8c2719e7803ac46d270762ece4aefc55c"

    livecheck do
      url "https://gitlab.com/akihe/radamsa/-/raw/v#{LATEST_VERSION}/Makefile?ref_type=tags"
      regex(/OWLURL=.*?ol[._-]v?(\d+(?:\.\d+)+)\.c/i)
    end
  end


  def install
    resource("ol.c").stage { buildpath.install Dir["*"].first => "ol.c" }
    system "make", "install", "PREFIX=#{prefix}"
    # Manually replace the manpage which is not reproducible
    rm(man1/"radamsa.1.gz")
    man1.install Utils::Gzip.compress("doc/radamsa.1")
  end

  test do
    assert_match "Radamsa is a general purpose fuzzer.", shell_output("#{bin}/radamsa --about")
    assert_match "drop a byte", shell_output("#{bin}/radamsa --list")
    assert_match version.to_s, shell_output("#{bin}/radamsa --version")
  end
end
