class LibnetfilterConntrack < Formula
  desc "Library providing an API to the in-kernel connection tracking state table"
  homepage "https://www.netfilter.org/projects/libnetfilter_conntrack/"
  url "https://www.netfilter.org/pub/libnetfilter_conntrack/libnetfilter_conntrack-1.1.1.tar.xz"
  sha256 "769d3eaf57fa4fbdb05dd12873b6cb9a5be7844d8937e222b647381d44284820"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d71d5587fd33174b7e9d09d487c5fd102d1cbac08cacdf5bf9cde2fba4189430"
  end

  livecheck do
    url "https://www.netfilter.org/projects/libnetfilter_conntrack/downloads.html"
    regex(/href=.*?libnetfilter_conntrack[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "libmnl"
  depends_on "libnfnetlink"
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
    flags = shell_output("pkgconf --cflags --libs libnetfilter_conntrack libmnl").chomp.split
    system ENV.cc, pkgshare/"examples/nfct-mnl-get.c", "-o", "nfct-mnl-get", *flags
    assert_match "mnl_socket_recvfrom: Operation not permitted", shell_output("./nfct-mnl-get inet 2>&1", 1)
  end
end
