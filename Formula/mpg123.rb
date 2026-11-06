class Mpg123 < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "47c15340db934890c7b46d0d43ce419aad5793334079d89c0d224451c5ccb41e"
  end

  desc "MP3 decoding library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/mpg123-1.32.8.tar.gz"
  sha256 "5a749a778aefce25efbd9f462bc87b1231f5ca8f49406bbeb3745a92bbd4b1f9"
  version "1.32.8"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    Dir["/usr/lib/libmpg123.so*", "/usr/lib/libout123.so*", "/usr/lib/libsyn123.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    Dir["/usr/include/mpg123.h", "/usr/include/out123.h", "/usr/include/syn123.h", "/usr/include/fmt123.h"].each { |h| (include/File.basename(h)).make_symlink h }
    %w[mpg123].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/libmpg123.pc","/usr/lib/pkgconfig/libmpg123.pc"].each { |pc| next unless File.exist?(pc); t = File.read(pc).gsub("libdir=/usr/lib","libdir=#{lib}").gsub("includedir=/usr/include","includedir=#{include}"); (lib/"pkgconfig/libmpg123.pc").write(t); break }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
