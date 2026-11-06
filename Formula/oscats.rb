class Oscats < Formula
  desc "Computerized adaptive testing system"
  homepage "https://code.google.com/archive/p/oscats/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/oscats/oscats-0.6.tar.gz"
  sha256 "2f7c88cdab6a2106085f7a3e5b1073c74f7d633728c76bd73efba5dc5657a604"
  license "GPL-3.0-or-later"
  revision 7


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "37f1905b5698b8828a095e48f824330002849c6005893b3eab432b847b63bb53"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "glib"
  depends_on "gsl"

  on_macos do
    depends_on "gettext"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  # Fix issue with conflicting definitions of select on Linux.
  # Patch submitted to discussion group:
  # https://groups.google.com/g/oscats/c/WZ7gRjkxmIk.
  patch do
    file "Patches/oscats/linux.patch"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
    pkgshare.install "examples"
    # Fix shim references in examples Makefile.
    if OS.mac?
      inreplace pkgshare/"examples/Makefile",
        Superenv.shims_path/"pkg-config",
        formula_opt_bin("pkgconf")/"pkg-config"
    else
      inreplace pkgshare/"examples/Makefile", Superenv.shims_path/"ld", "ld"
    end
  end

  test do
    pkgconf_flags = shell_output("pkgconf --cflags --libs oscats glib-2.0").chomp.split
    system ENV.cc, "-Wno-incompatible-pointer-types", pkgshare/"examples/ex01.c", *pkgconf_flags, "-o", "ex01"
    assert_match "Done", shell_output("#{testpath}/ex01")
  end
end
