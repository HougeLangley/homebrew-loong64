class Mp4v2 < Formula
  desc "Read, create, and modify MP4 files"
  homepage "https://mp4v2.org"
  url "https://github.com/enzo1982/mp4v2/releases/download/v2.1.3/mp4v2-2.1.3.tar.bz2"
  sha256 "033185c17bf3c5fdd94020c95f8325be2e5356558e3913c3d6547a85dd61f7f1"
  license "MPL-1.1"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1ff4ec9e78fedac09eadd1d6e052392c15304fa8203706043c15f211b6ed3dc4"
  end


  conflicts_with "bento4",
    because: "both install `mp4extract` and `mp4info` binaries"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
    system "make", "install-man"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mp4art --version")
  end
end
