class Fakeroot < Formula
  desc "Provide a fake root environment"
  homepage "https://tracker.debian.org/pkg/fakeroot"
  url "https://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_2.1.4.orig.tar.xz"
  sha256 "0822bd5a9f0cf19d2ba0546b88b0432d4d3d9917db62c57b74044ccadba06e49"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://deb.debian.org/debian/pool/main/f/fakeroot/"
    regex(/href=.*?fakeroot[._-]v?(\d+(?:\.\d+)+)[._-]orig\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e9506c48ff8c3a277f32cdea13e028e13798cd4a45194a5acc89142c3676d907"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_linux do
    depends_on "libcap" => :build
  end

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

    system "autoreconf", "--force", "--install", "--verbose"

    args = ["--disable-silent-rules"]
    args << "--disable-static" if OS.mac?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args.reject { |s| s["--disable-debug"] }
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fakeroot -v")
  end
end
