class JpegTurbo < Formula
  desc "JPEG image codec (system stub)"
  homepage "https://libjpeg-turbo.org/"
  url "file:///home/houge/infra/srv/stubs/jpeg-turbo-3.2.0.tar.gz"
  sha256 "8379af816f286293c0efff721578aef6401e7bab8ba394686e202cf61a3ccd60"
  version "3.2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "75c10a28f74b82cceaea793e8afcc750dd34a5bf523ab2d11f9bbd49db8c00a8"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    Dir["/usr/include/j*.h"].each { |h| (include/File.basename(h)).make_symlink h }
    Dir["/usr/lib/libjpeg.so*", "/usr/lib/libturbojpeg.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    %w[cjpeg djpeg jpegtran tjbench].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"pkgconfig").mkpath
    ["/usr/lib/64/pkgconfig/libjpeg.pc", "/usr/lib/pkgconfig/libjpeg.pc"].each do |pc|
      next unless File.exist?(pc)
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/libjpeg.pc").write(t)
      break
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate include/"jpeglib.h", :exist?
  end
end
