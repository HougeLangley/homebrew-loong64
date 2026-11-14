class Afuse < Formula
  desc "Automounting file system implemented in userspace with FUSE"
  homepage "https://github.com/pcarrier/afuse/"
  url "https://github.com/pcarrier/afuse/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "87284e3f7973f5a61eea4a37880512c01f0b8bf1d37a8988447efbe806ec3414"
  license "GPL-2.0-only"


  # Last release on 2022-02-21. Needs `libfuse@2` to build.
  # Can be undeprecated if https://github.com/pcarrier/afuse/pull/14 is merged
  deprecate! date: "2026-06-21", because: :unmaintained
  disable! date: "2027-06-21", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "59a0538ea3688de3e9fbe23caebf66b13b73db41ce893858c645a8280dffc2b6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "libfuse@2"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./autogen.sh"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "FUSE library version", shell_output("#{bin}/afuse --version 2>&1", 1)
  end
end
