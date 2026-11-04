class Libb2 < Formula
  desc "BLAKE2 hash function library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/libb2-0.98.1.tar.gz"
  sha256 "5a749a778aefce25efbd9f462bc87b1231f5ca8f49406bbeb3745a92bbd4b1f9"
  version "0.98.1"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    Dir["/usr/lib/libb2.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    Dir["/usr/include/blake2*.h"].each { |h| (include/File.basename(h)).make_symlink h }
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/libb2.pc","/usr/lib/pkgconfig/libb2.pc"].each { |pc| next unless File.exist?(pc); t = File.read(pc).gsub("libdir=/usr/lib","libdir=#{lib}").gsub("includedir=/usr/include","includedir=#{include}"); (lib/"pkgconfig/libb2.pc").write(t); break }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
