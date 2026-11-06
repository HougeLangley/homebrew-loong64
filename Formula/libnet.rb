class Libnet < Formula
  desc "C library for creating IP packets"
  homepage "https://codedocs.xyz/libnet/libnet/"
  url "https://github.com/libnet/libnet/releases/download/v1.3/libnet-1.3.tar.gz"
  sha256 "ad1e2dd9b500c58ee462acd839d0a0ea9a2b9248a1287840bc601e774fb6b28f"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fa4dfbb5144fde833b226e0cf3a3e67360b0bcda24fc01217d6834e7082b7b15"
  end

  compatibility_version 1


  depends_on "doxygen" => :build
  depends_on "pkgconf" => :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdint.h>
      #include <libnet.h>

      int main(int argc, const char *argv[])
      {
        printf("%s", libnet_version());
        return 0;
      }
    C

    flags = shell_output("pkgconf --libs --cflags libnet").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    assert_match version.to_s, shell_output("./test")
  end
end
