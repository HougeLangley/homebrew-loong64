class Bc < Formula
  desc "Arbitrary precision numeric processing language"
  homepage "https://www.gnu.org/software/bc/"
  url "https://ftpmirror.gnu.org/bc/bc-1.08.2.tar.gz"
  mirror "https://ftp.gnu.org/gnu/bc/bc-1.08.2.tar.gz"
  sha256 "ae470fec429775653e042015edc928d07c8c3b2fc59765172a330d3d87785f86"
  license "GPL-3.0-or-later"


  keg_only :provided_by_macos # before Ventura

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5284f61f420be0a6b698fd345487c58fe9b51cbdf482d9efd7dc1d3b015bafc3"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "ed" => :build
  uses_from_macos "flex"
  uses_from_macos "libedit"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  conflicts_with "bc-gh", because: "both install `bc` and `dc` binaries"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # prevent user BC_ENV_ARGS from interfering with or influencing the
    # bootstrap phase of the build, particularly
    # BC_ENV_ARGS="--mathlib=./my_custom_stuff.b"
    ENV.delete("BC_ENV_ARGS")

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--with-libedit",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"bc", "--version"
    assert_match "2", pipe_output(bin/"bc", "1+1\n", 0)
  end
end
