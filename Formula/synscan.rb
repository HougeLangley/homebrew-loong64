class Synscan < Formula
  desc "Asynchronous half-open TCP portscanner"
  homepage "https://digit-labs.org/files/tools/synscan/"
  url "https://digit-labs.org/files/tools/synscan/releases/synscan-5.02.tar.gz"
  sha256 "c4e6bbcc6a7a9f1ea66f6d3540e605a79e38080530886a50186eaa848c26591e"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3b00cc4c512fa38132e8e917795d143965ad8d9a3b6d747f683dd8615da9915c"
  end

  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?synscan[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "libpcap"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Ideally we pass the prefix into --with-libpcap, but that option only checks "flat"
    # i.e. it only works if the headers and libraries are in the same directory.
    ENV.append_to_cflags "-I#{formula_opt_include("libpcap")}"
    ENV.append "LIBS", "-L#{formula_opt_lib("libpcap")} -lpcap"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}",
                          "--with-libpcap=yes"

    target = OS.mac? ? "macos" : OS.kernel_name.downcase
    system "make", target
    system "make", "install"
  end

  test do
    system bin/"synscan", "-V"
  end
end
