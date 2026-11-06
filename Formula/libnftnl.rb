class Libnftnl < Formula
  desc "Netfilter library providing interface to the nf_tables subsystem"
  homepage "https://netfilter.org/projects/libnftnl/"
  url "https://www.netfilter.org/pub/libnftnl/libnftnl-1.3.2.tar.xz"
  sha256 "c97abc3409f8fa396b4462b2bb7f147a3a47a4ddc97cfa0b2f18890c9cfde8b0"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c70cc35c4440f8a73f6017b1a5090819ad035fb7b1d5fcfe47fc62a0e4ab76f8"
  end

  livecheck do
    url "https://www.netfilter.org/projects/libnftnl/downloads.html"
    regex(/href=.*?libnftnl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "libmnl"
  depends_on :linux

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
    pkgshare.install "examples"
    inreplace pkgshare/"examples/Makefile", Superenv.shims_path/"ld", "ld"
  end

  test do
    flags = shell_output("pkgconf --cflags --libs libnftnl libmnl").chomp.split
    system ENV.cc, pkgshare/"examples/nft-set-get.c", "-o", "nft-set-get", *flags
    assert_match "error: Operation not permitted", shell_output("./nft-set-get inet 2>&1", 1)
  end
end
