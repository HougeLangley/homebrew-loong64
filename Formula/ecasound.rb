class Ecasound < Formula
  desc "Multitrack-capable audio recorder and effect processor"
  homepage "https://nosignal.fi/ecasound/"
  url "https://nosignal.fi/download/ecasound-2.9.3.tar.gz"
  sha256 "468bec44566571043c655c808ddeb49ae4f660e49ab0072970589fd5a493f6d4"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://nosignal.fi/ecasound/download.php"
    regex(/href=.*?ecasound[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a0234d61fa2f92ac8e0e266f001732c1f2c0eb227ac6695f624575a1e44d1e7f"
  end

  depends_on "jack"
  depends_on "libsamplerate"
  depends_on "libsndfile"

  uses_from_macos "ncurses"

  on_linux do
    depends_on "alsa-lib"
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

    args = %w[
      --enable-rubyecasound=no
      --enable-sys-readline=no
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.wav")
    system bin/"ecasound", "-i", "resample,auto,#{fixture}", "-o", testpath/"test.cdr"
    assert_path_exists testpath/"test.cdr"
  end
end
