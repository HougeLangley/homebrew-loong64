class Dirac < Formula
  desc "General-purpose video codec aimed at a range of resolutions"
  homepage "https://sourceforge.net/projects/dirac/"
  url "https://downloads.sourceforge.net/project/dirac/dirac-codec/Dirac-1.0.2/dirac-1.0.2.tar.gz"
  mirror "https://cdn.netbsd.org/pub/pkgsrc/distfiles/dirac-1.0.2.tar.gz"
  sha256 "816b16f18d235ff8ccd40d95fc5b4fad61ae47583e86607932929d70bf1f00fd"
  license any_of: ["MPL-1.1", "GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bbc1375462cf33a78d88d536e719412f17036feba15ed79998d7b831a7293373"
  end


  # First two patches: the only two commits in the upstream repo not in 1.0.2

  patch do
    url "https://gist.githubusercontent.com/mistydemeo/da8a53abcf057c58b498/raw/bde69c5f07d871542dcb24792110e29e6418d2a3/unititialized-memory.patch"
    sha256 "d5fcbb1b5c9f2f83935d71ebd312e98294121e579edbd7818e3865606da36e10"
    type :backport
  end

  patch do
    url "https://gist.githubusercontent.com/mistydemeo/e729c459525d0d6e9e2d/raw/d9ff69c944b8bde006eef27650c0af36f51479f5/dirac-gcc-fixes.patch"
    sha256 "52c40f2c8aec9174eba2345e6ba9689ced1b8f865c7ced23e7f7ee5fdd6502c3"
    type :backport
    resolves "https://sourceforge.net/p/dirac/bugs/2984304/"
  end

  # HACK: the configure script, which assumes any compiler that
  # starts with "cl" is a Microsoft compiler
  patch do
    file "Patches/dirac/1.0.2.patch"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # BSD cp doesn't have '-d'
    inreplace "doc/Makefile.in", "cp -dR", "cp -R"

    # Workaround for newer Clang
    ENV.append_to_cflags "-Wno-c++11-narrowing" if DevelopmentTools.clang_build_version >= 1700

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    touch "test.in"
    system "#{bin}/dirac_decoder", "test.in", "test.out"
    assert_path_exists "test.out"
  end
end
