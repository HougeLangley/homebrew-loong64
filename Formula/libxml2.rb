class Libxml2 < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0d8f7f93e87f372650f28f73560303bbaadaff8d4d72f4739e10e6488f7751b0"
  end

  desc "GNOME XML library (system stub)"
  homepage "https://xmlsoft.org/"
  url "file:///home/houge/infra/srv/stubs/libxml2-2.15.4.tar.gz"
  sha256 "b59bf5acdbfd9ffcb04edd59e55a684742334a0cb76d811fd3291ed9ebb1bb9b"
  version "2.15.4"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"libxml2").mkpath
    cp_r "/usr/include/libxml2/libxml", include/"libxml2/libxml" if Dir.exist?("/usr/include/libxml2/libxml")
    # 老代码直接 #include <libxml/xxx.h>，需要扁平路径
    (include/"libxml").make_symlink include/"libxml2/libxml" if Dir.exist?("/usr/include/libxml2/libxml")
    Dir["/usr/lib/libxml2.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    %w[xml2-config xmllint].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"pkgconfig").mkpath
    if File.exist?("/usr/lib/64/pkgconfig/libxml-2.0.pc") || File.exist?("/usr/lib/pkgconfig/libxml-2.0.pc")
      pc = File.exist?("/usr/lib/64/pkgconfig/libxml-2.0.pc") ? "/usr/lib/64/pkgconfig/libxml-2.0.pc" : "/usr/lib/pkgconfig/libxml-2.0.pc"
      t = File.read(pc).gsub("/usr/include/libxml2", "#{include}/libxml2").gsub("libdir=/usr/lib", "libdir=#{lib}")
      # 系统的 libxml2 编译时带了 ICU/zlib，.pc 里会带这些依赖的 -I。
      # 但依赖 libxml2 的配方不会声明 icu4c，构建时 PKG_CONFIG_PATH 里没有它，
      # pkg-config 解析 cflags 就会失败（"Could not generate cflags for libxml-2.0"）。
      # 头文件路径来自系统 /usr，这些额外 -I 对消费者没有意义，直接去掉。
      t = t.lines.reject { |l| l.start_with?("Cflags:") }.join
      # Requires.private 同理：消费者不会声明 zlib/icu4c，解析时会失败
      t = t.lines.reject { |l| l.start_with?("Requires.private:") }.join
      t += "Cflags: -I#{include}/libxml2\n"
      (lib/"pkgconfig/libxml-2.0.pc").write(t)
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate include/"libxml2/libxml/parser.h", :exist?
  end
end
