class Pcre2 < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7c0d38e87f5ef4e5ac5924b5015b865b0dc510cdfe026279a86698d85b902698"
  end

  desc "Perl compatible regular expressions library (system stub)"
  homepage "https://www.pcre.org/"
  url "file:///home/houge/infra/srv/stubs/pcre2-10.48.tar.gz"
  sha256 "e7a98280bb6cabcca6c7c56abaccb038dcab73bdd2220ca2970cf7343a0b2980"
  version "10.48"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"pcre2").mkpath
    Dir["/usr/include/pcre2*.h"].each { |h| (include/File.basename(h)).make_symlink h }
    cp_r "/usr/include/pcre2/pcre2.h", include/"pcre2/pcre2.h" if File.exist?("/usr/include/pcre2/pcre2.h")
    Dir["/usr/lib/libpcre2-*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/libpcre2-8.pc", "/usr/lib/pkgconfig/libpcre2-8.pc"].each do |pc|
      next unless File.exist?(pc)
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/libpcre2-8.pc").write(t)
      break
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate lib/"libpcre2-8.so", :exist?
  end
end
