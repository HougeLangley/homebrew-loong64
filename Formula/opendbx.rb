class Opendbx < Formula
  desc "Lightweight but extensible database access library in C"
  homepage "https://linuxnetworks.de/doc/index.php/OpenDBX"
  url "https://linuxnetworks.de/opendbx/download/opendbx-1.4.6.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/libo/libopendbx/libopendbx_1.4.6.orig.tar.gz"
  sha256 "2246a03812c7d90f10194ad01c2213a7646e383000a800277c6fb8d2bf81497c"
  license "LGPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e2d2d027c0190a4bb2f434c96069055792ad26f106018035c12ff2b5bd2c7e6f"
  end

  revision 2

  # The download page includes a `libopendbx` development release, so we use a
  # leading forward slash to only match `opendbx` versions.
  livecheck do
    url "https://linuxnetworks.de/doc/index.php?title=OpenDBX/Download"
    regex(%r{href=.*?/opendbx[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  depends_on "readline"
  depends_on "sqlite"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.cxx11

    # Reported upstream: http://bugs.linuxnetworks.de/index.php?do=details&id=40
    inreplace "utils/Makefile.in", "$(LIBSUFFIX)", ".dylib" if OS.mac?

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--with-backends=sqlite3", *args, *std_configure_args
    system "make", "install"
  end

  test do
    testfile = testpath/"test.sql"
    testfile.write <<~SQL
      create table t(x);
      insert into t values("Hello");
      .header
      select * from t;
      .quit
    SQL

    assert_match '"Hello"',
      pipe_output("#{bin}/odbx-sql odbx-sql -h ./ -d test.sqlite3 -b sqlite3", (testpath/"test.sql").read)
  end
end
