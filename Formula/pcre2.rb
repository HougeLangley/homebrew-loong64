class Pcre2 < Formula

  desc "Perl compatible regular expressions library (system stub)"
  homepage "https://www.pcre.org/"
  url "file:///home/houge/infra/srv/stubs/pcre2-10.48.tar.gz"
  sha256 "e7a98280bb6cabcca6c7c56abaccb038dcab73bdd2220ca2970cf7343a0b2980"
  version "10.48"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f7cb24f4ef96e72ace3e13bb2c2c8538eeee873bdd360748aa7915c5a10a9725"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"pcre2").mkpath
    Dir["/usr/include/pcre2*.h"].each { |h| (include/File.basename(h)).make_symlink h }
    cp_r "/usr/include/pcre2/pcre2.h", include/"pcre2/pcre2.h" if File.exist?("/usr/include/pcre2/pcre2.h")
    Dir["/usr/lib/libpcre2-*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (lib/"pkgconfig").mkpath
    # Bridge EVERY system pcre2 .pc (8/16/32/posix): wxwidgets resolves
    # libpcre2-32 via pkg-config and previously fell back to the missing
    # release-tarball submodule (gambit chain evidence).
    ["/usr/lib/64/pkgconfig", "/usr/lib/pkgconfig"].each do |dir|
      Dir["#{dir}/libpcre2-*.pc"].each do |pc|
        t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
        (lib/"pkgconfig/#{File.basename(pc)}").write(t)
      end
      break if Dir.exist?("#{dir}/libpcre2-8.pc") || !Dir.glob("#{dir}/libpcre2-*.pc").empty?
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate lib/"libpcre2-8.so", :exist?
  end
end
