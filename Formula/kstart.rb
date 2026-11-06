class Kstart < Formula
  desc "Modified version of kinit that can use keytabs to authenticate"
  homepage "https://www.eyrie.org/~eagle/software/kstart/"
  url "https://archives.eyrie.org/software/kerberos/kstart-4.3.tar.xz"
  sha256 "7a3388ae79927c6698dc1bf20b29717e6bc34f692e00f12b3369d896f6702060"
  license all_of: ["MIT", "FSFAP", "ISC"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "30a66adc73c97278c9039fea476f33af8b4f8a3c35fa92ee0f925b7f06fec0ff"
  end

  livecheck do
    url :homepage
    regex(/href=.*?kstart[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "krb5"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"k5start", "-h"
  end
end
