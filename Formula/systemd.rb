class Systemd < Formula
  desc "System and service manager (system stub)"
  homepage "https://systemd.io/"
  url "file:///home/houge/infra/srv/stubs/systemd-258.tar.gz"
  sha256 "351d7603337b157ed57d398f69b47a42977833cf1a343f0d39a94fbca9f698b6"
  version "258"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "10102ce50d93075f1d1fd7fe51fbf5d87a3c8112e633474ecace00b40b8b0563"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"systemd").mkpath
    cp_r Dir["/usr/include/systemd/*"], include/"systemd" if Dir.exist?("/usr/include/systemd")
    Dir["/usr/lib/libsystemd.so*", "/usr/lib/libudev.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    %w[systemctl journalctl].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/libsystemd.pc", "/usr/lib/pkgconfig/libsystemd.pc"].each do |pc|
      next unless File.exist?(pc)
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/libsystemd.pc").write(t)
      break
    end
    # Bridge libudev.pc as well: xorg-server's meson looks up the "libudev"
    # dependency via pkg-config and superenv does not search /usr/lib/pkgconfig
    # (xrdb/xmodmap chains died on exactly this).
    ["/usr/lib/64/pkgconfig/libudev.pc", "/usr/lib/pkgconfig/libudev.pc"].each do |pc|
      next unless File.exist?(pc)
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/libudev.pc").write(t)
      break
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate include/"systemd/sd-bus.h", :exist?
    assert_predicate lib/"pkgconfig/libudev.pc", :exist? if File.exist?("/usr/lib/pkgconfig/libudev.pc")
  end
end
