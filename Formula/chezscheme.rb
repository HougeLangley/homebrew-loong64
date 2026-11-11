class Chezscheme < Formula
  desc "Implementation of the Chez Scheme language"
  homepage "https://cisco.github.io/ChezScheme/"
  url "https://github.com/cisco/ChezScheme/releases/download/v10.4.1/csv10.4.1.tar.gz"
  sha256 "2e74952db7bc177f0c3602e2217a341ba677d733eec4cd7726418c3a4e1ef308"
  license "Apache-2.0"
  compatibility_version 2



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ce05364371005852c7a2d98b58ac4db8770e7ee8c84338ea2d0745cdb16a19d4"
  end

  depends_on "libx11" => :build
  depends_on "xterm" => :build

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    inreplace "c/version.h", "/usr/X11R6", formula_opt_prefix("libx11")
    inreplace "c/expeditor.c", "/usr/X11/bin/resize", formula_opt_bin("xterm")/"resize"

    system "./configure",
              "--installprefix=#{prefix}",
              "--threads",
              "--installschemename=chez"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"hello.ss").write <<~SCHEME
      (display "Hello, World!") (newline)
    SCHEME

    expected = <<~EOS
      Hello, World!
    EOS

    assert_equal expected, shell_output("#{bin}/chez --script hello.ss")
  end
end
