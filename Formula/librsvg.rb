class Librsvg < Formula
  desc "Library to render SVG files using Cairo (system stub)"
  homepage "https://wiki.gnome.org/Projects/LibRsvg"
  url "file:///home/houge/infra/srv/stubs/librsvg-2.1.0.tar.gz"
  sha256 "97fe2fe83e5546f8d2b405e28e16a4d0608816446ba0aad3cb2c3bd18a8d154a"
  version "2.60.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9a065610e49b783cb1407c544f95d9cf37f44761fc5bdcefe1ac8592841d7426"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    # Bridge system librsvg
    %w[rsvg-convert].each do |tool|
      src = "/usr/bin/#{tool}"
      (bin/tool).make_symlink src if File.exist?(src)
    end
    Dir["/usr/lib/librsvg*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (lib/"pkgconfig").mkpath
    Dir["/usr/lib/pkgconfig/librsvg*.pc"].each do |pc|
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/#{File.basename(pc)}").write(t)
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
    assert_predicate bin/"rsvg-convert", :exist? if File.exist?("/usr/bin/rsvg-convert")
  end
end
