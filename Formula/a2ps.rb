class A2ps < Formula
  desc "Any-to-PostScript filter"
  homepage "https://www.gnu.org/software/a2ps/"
  url "https://ftpmirror.gnu.org/a2ps/a2ps-4.15.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/a2ps/a2ps-4.15.8.tar.gz"
  sha256 "8d13915a36ebbfa8e7b236b350cc81adc714acb217a18e8d8c60747c0ad353f9"
  license "GPL-3.0-or-later"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cfb03de95ae6aefb865c20598b70add602619f12cf55e4d31b7d58a0d9a19a80"
  end

  depends_on "pkgconf" => :build
  depends_on "bdw-gc"
  depends_on "libpaper"

  deny_network_access!

  def install
    system "./configure", "--sysconfdir=#{etc}",
                          "--with-lispdir=#{elisp}",
                          "--with-packager=#{tap.user}",
                          "--with-packager-version=#{pkg_version}",
                          "--with-packager-bug-reports=#{tap.issues_url}",
                          *std_configure_args
    system "make"
    # Avoid overwriting existing a2ps.cfg
    system "make", "install", "sysconfdir=#{prefix}/etc"
    inreplace prefix/"etc/a2ps.cfg", prefix, opt_prefix
    etc.install (prefix/"etc").children
  end

  test do
    (testpath/"test.txt").write("Hello World!\n")
    system bin/"a2ps", "test.txt", "-o", "test.ps"
    assert_match "(Hello World!) p n\n", File.read("test.ps")
  end
end
