class Shellinabox < Formula
  desc "Export command-line tools to web based terminal emulator"
  homepage "https://github.com/shellinabox/shellinabox"
  url "https://github.com/shellinabox/shellinabox/archive/refs/tags/v2.21.tar.gz"
  sha256 "2a8f94beb286d0851bb146f7a7c480a8740f59b959cbd274e21a8fcbf0a7f307"
  license "GPL-2.0-only" => { with: "GPL-3.0-linking-source-exception" } # OpenSSL exception

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "28ee73a0ca71ef79dcaab6eaa5765eeb88911e4c1abf4d5bf91c3351a6061696"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Upstream (Debian) patch for OpenSSL 1.1 compatibility
  patch do
    file "Patches/shellinabox/2.20.patch"
    type :unofficial
    resolves "https://github.com/shellinabox/shellinabox/pull/467"
  end

  allow_network_access! :test

  def install
    # Workaround for Xcode 14.3
    # https://github.com/shellinabox/shellinabox/issues/518
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    port = free_port
    pid = spawn bin/"shellinaboxd", "--port=#{port}", "--disable-ssl", "--localhost-only"
    sleep 1
    assert_match "ShellInABox - Make command line applications available as AJAX web applications",
                 shell_output("curl -s http://localhost:#{port}")
    Process.kill "TERM", pid
    Process.wait pid
  end
end
