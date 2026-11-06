class Fstrm < Formula
  desc "Frame Streams implementation in C"
  homepage "https://github.com/farsightsec/fstrm"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8416fcdd34d8c4f00e95f1e9e22b8325bc2fbcfa36ff4a99d3ab54380d16b23c"
  end

  stable do
    url "https://dl.farsightsecurity.com/dist/fstrm/fstrm-0.6.1.tar.gz"
    sha256 "bca4ac1e982a2d923ccd24cce2c98f4ceeed5009694430f73fc0dcebca8f098f"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      file "Patches/libtool/configure-big_sur.diff"
    end
  end

  # GitHub release descriptions contain a link to the `stable` tarball.
  livecheck do
    url :head
    strategy :github_latest
  end


  head do
    url "https://github.com/farsightsec/fstrm.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libevent"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    job = spawn bin/"fstrm_capture", "-t", "protobuf:dnstap.Dnstap",
                                     "-u", "dnstap.sock", "-w", "capture.fstrm", "-dddd"
    sleep 2

    system bin/"fstrm_dump", "capture.fstrm"
  ensure
    Process.kill("TERM", job)
  end
end
