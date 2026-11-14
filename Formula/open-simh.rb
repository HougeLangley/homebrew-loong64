class OpenSimh < Formula
  desc "Multi-system computer simulator"
  homepage "https://opensimh.org/"
  url "https://github.com/open-simh/simh/archive/refs/tags/v3.12-3.tar.gz"
  sha256 "9d0370c79e8910fa1cd2b19d23885bfaa5564df86101c40481dd9b6e64593b18"
  license "MIT"
  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c978fb1a8ea55f0f51cff2f9081297b425c493b7d21a7d41c8a3d5d54b4544d2"
  end

  head "https://github.com/open-simh/simh.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:-\d+)?)$/i)
  end



  depends_on "libpng"
  depends_on "vde"

  uses_from_macos "libedit"
  uses_from_macos "libpcap"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "nova-fairwinds", because: "both install `nova` binaries"
  conflicts_with "sigma-cli", because: "both install `sigma` binaries"

  def install
    if OS.linux?
      ENV.append_to_cflags "-fcommon"
      inreplace "makefile", "+= /usr/lib/", "+= /usr/lib/ #{HOMEBREW_PREFIX}/lib/"
    end
    system "make", "GCC=#{ENV.cc}", "CFLAGS_G=#{ENV.cflags}", "all"

    bin.install Dir["BIN/*"]
    doc.install Dir["doc/*"]
    Dir["**/*.txt"].each do |f|
      (doc/File.dirname(f)).install f
    end
    (pkgshare/"vax").install Dir["VAX/*.{bin,exe}"]
  end

  test do
    assert_match "Goodbye", pipe_output("#{bin}/altair", "exit\n", 0)
  end
end
