class Fcgi < Formula
  desc "Protocol for interfacing interactive programs with a web server"
  # Last known good original homepage: https://web.archive.org/web/20080906064558/www.fastcgi.com/
  homepage "https://fastcgi-archives.github.io/"
  url "https://github.com/FastCGI-Archives/fcgi2/archive/refs/tags/2.4.7.tar.gz"
  sha256 "e41ddc3a473b555bdc0cbd80703dcb1f4610c1a7700d3b9d3d0c14a416e1074b"
  license "OML"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a981948f09d42fda504bcdf037be17b524975c30ffb05c71bc96285443f924b9"
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen.sh"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"testfile.c").write <<~C
      #include "fcgi_stdio.h"
      #include <stdlib.h>
      int count = 0;
      int main(void){
        while (FCGI_Accept() >= 0){
        printf("Request number %d running on host %s", ++count, getenv("SERVER_HOSTNAME"));}}
    C
    system ENV.cc, "testfile.c", "-L#{lib}", "-lfcgi", "-o", "testfile"
    assert_match "Request number 1 running on host", shell_output("./testfile")
  end
end
