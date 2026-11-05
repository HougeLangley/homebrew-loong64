class Streamripper < Formula
  desc "Separate tracks via Shoutcasts title-streaming"
  homepage "https://streamripper.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/streamripper/streamripper%20%28current%29/1.64.6/streamripper-1.64.6.tar.gz"
  sha256 "c1d75f2e9c7b38fd4695be66eff4533395248132f3cc61f375196403c4d8de42"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "94dce88ccf32dcee59ce0318f52aece9bcd5d29b7ac9c8e8ede893b4cbb18ff5"
  end

  revision 2

  livecheck do
    url :stable
    regex(%r{url=.*?/streamripper[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "mad"

  on_macos do
    depends_on "gettext"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # the Makefile ignores CPPFLAGS from the environment, which
    # breaks the build when HOMEBREW_PREFIX is not /usr/local
    ENV.append_to_cflags ENV.cppflags if ENV.cppflags.present?

    # Work around error: call to undeclared library function 'strcpy'.
    # Ref: https://sourceforge.net/p/streamripper/code/ci/master/tree/lib/argv.c#l33
    ENV.append_to_cflags "-DANSI_PROTOTYPES=1" if DevelopmentTools.clang_build_version >= 1403

    # remove bundled libmad
    rm_r(buildpath/"libmad-0.15.1b")

    chmod 0755, "./install-sh" # or "make install" fails

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"streamripper", "--version"
  end
end
