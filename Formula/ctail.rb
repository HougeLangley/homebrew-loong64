class Ctail < Formula
  desc "Tool for operating tail across large clusters of machines"
  homepage "https://github.com/pquerna/ctail"
  url "https://github.com/pquerna/ctail/archive/refs/tags/ctail-0.1.0.tar.gz"
  sha256 "864efb235a5d076167277c9f7812ad5678b477ff9a2e927549ffc19ed95fa911"
  license "Apache-2.0"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6c72085ea5f2cfec0f7e34369d6a3997ddbfa85379787fcca46a41336ddebd24"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "apr"
  depends_on "apr-util"

  conflicts_with "byobu", because: "both install `ctail` binaries"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Workaround for ancient config files not recognizing aarch64 macos.
    system "autoreconf", "--force", "--install", "--verbose" if Hardware::CPU.arm?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args,
                          "--with-apr=#{formula_opt_bin("apr")}",
                          "--with-apr-util=#{formula_opt_bin("apr-util")}"
    system "make", "LIBTOOL=glibtool --tag=CC"
    system "make", "install"
  end

  test do
    system bin/"ctail", "-h"
  end
end
