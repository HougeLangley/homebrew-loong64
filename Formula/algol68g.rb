class Algol68g < Formula
  desc "Algol 68 compiler-interpreter"
  homepage "https://algol68genie.nl/en/algol-68-genie/"
  # Upstream repacked 3.13.4 on 2026-10-15 without changing its version.
  # The original tarball in Fedora's 3.13.4-1.fc46 SRPM has the old SHA-256;
  # only the _Float128/__float128 configure probes (adding volatile) and the
  # man-page date differ. See the official source repository and Arch 3.13.4-1.
  url "https://algol68genie.nl/algol68g-3.13.4.tar.gz"
  sha256 "625746ccb08e6fbfea1f526400cf21068ab2af34f6b64756ccc20e37e4d2d4f8"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?algol68g[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "231de4304f45c39cebaef963849ecee51dd7ffd21ccbc8fb408769f67dc2b098"
  end

  depends_on "readline"

  uses_from_macos "curl"
  uses_from_macos "ncurses"

  on_linux do
    depends_on "libpq"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    path = testpath/"hello.alg"
    path.write <<~ALGOL
      print("Hello World")
    ALGOL

    assert_equal "Hello World", shell_output("#{bin}/a68g #{path}").strip
  end
end
