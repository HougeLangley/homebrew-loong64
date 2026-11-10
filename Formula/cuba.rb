class Cuba < Formula
  desc "Library for multidimensional numerical integration"
  homepage "https://feynarts.de/cuba/"
  url "https://feynarts.de/cuba/Cuba-4.2.2.tar.gz"
  sha256 "8d9f532fd2b9561da2272c156ef7be5f3960953e4519c638759f1b52fe03ed52"
  license "LGPL-3.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?Cuba[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f7367c07988c8b9270157be2728b5b722cd2a367008539036708187148b62905"
  end

  def install
    # Keep the generated makefile's @DEFS@, REALSIZE and src/common includes.
    # A command-line CFLAGS override used to discard them and lose stddecl.h.
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.deparallelize
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "demo"
  end

  test do
    extra = %w[-std=gnu17 -D_GNU_SOURCE]
    system ENV.cc, *extra, pkgshare/"demo/demo-c.c", "-o", "demo", "-L#{lib}", "-lcuba", "-lm"
    system "./demo"
  end
end
