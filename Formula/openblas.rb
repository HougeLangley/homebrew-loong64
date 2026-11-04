class Openblas < Formula
  desc "Optimized BLAS library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/openblas-0.3.34.tar.gz"
  sha256 "67a7f9070adc079c27791366db1ee01799be7b6a872d23169aba17023a6dde31"
  version "0.3.34"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    Dir["/usr/lib/libopenblas*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (include/"openblas").mkpath
    cp_r Dir["/usr/include/openblas/*"], include/"openblas" if Dir.exist?("/usr/include/openblas")
    (include/"cblas.h").make_symlink "/usr/include/cblas.h" if File.exist?("/usr/include/cblas.h")
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/openblas.pc","/usr/lib/pkgconfig/openblas.pc"].each { |pc| next unless File.exist?(pc); t = File.read(pc).gsub("libdir=/usr/lib","libdir=#{lib}").gsub("includedir=/usr/include","includedir=#{include}"); (lib/"pkgconfig/openblas.pc").write(t); break }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
