class Libnl < Formula
  desc "Netlink protocol library suite (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/libnl-3.9.0.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "3.9.0"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libnl-3.so.200").make_symlink "/usr/lib/libnl-3.so.200" if File.exist?("/usr/lib/libnl-3.so.200")
    cp_r "/usr/include/libnl3/netlink", include/"netlink" if Dir.exist?("/usr/include/libnl3/netlink")
    (lib/"pkgconfig").mkpath
    Dir["/usr/lib/64/pkgconfig/libnl*.pc"].each { |pc| t = File.read(pc).gsub("/usr/include", include.to_s).gsub("libdir=/usr/lib", "libdir=#{lib}"); (lib/"pkgconfig"/File.basename(pc)).write(t) }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
