class Aldo < Formula
  desc "Morse code learning tool released under GPL"
  homepage "https://www.nongnu.org/aldo/"
  url "https://download.savannah.gnu.org/releases/aldo/aldo-0.7.7.tar.bz2"
  sha256 "f1b8849d09267fff3c1f5122097d90fec261291f51b1e075f37fad8f1b7d9f92"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://download.savannah.gnu.org/releases/aldo/"
    regex(/href=.*?aldo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cbc59c6b64122de94e77072536208ebba765de42bb59d1983a07eff9f84733f0"
  end

  depends_on "libao"

  patch do
    file "Patches/aldo/0.7.7.patch"
    type :unofficial
    resolves "https://savannah.nongnu.org/bugs/index.php?42127"
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "Aldo #{version} Main Menu", pipe_output(bin/"aldo", "6", 0)
  end
end
