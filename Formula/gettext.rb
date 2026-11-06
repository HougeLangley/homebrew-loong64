class Gettext < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ef5c11cad6c17338514c09b3e412591e6e04abdc99f64197e12659072ee5c082"
  end

  desc "GNU internationalization library (system stub)"
  homepage "https://www.gnu.org/software/gettext/"
  url "file:///home/houge/infra/srv/stubs/gettext-1.0.tar.gz"
  sha256 "0a64b4701dc4a0c28ead814e3161decc872da89aa34295fa475995664a4b79d8"
  version "1.0"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    # brew 自编的 gettext 在 16K 页内核上会 SIGBUS，改用系统版本
    %w[msgfmt msgmerge msgcat xgettext msgattrib msgconv msgen msgexec
       msgfilter msggrep msginit msgunfmt msguniq gettext gettextize ngettext envsubst].each do |t|
      (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}")
    end
    Dir["/usr/lib/libgettext*.so*", "/usr/lib/libintl.so*", "/usr/lib/libasprintf.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (include/"gettext").mkpath
    cp_r Dir["/usr/include/gettext/*"], include/"gettext" if Dir.exist?("/usr/include/gettext")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate bin/"msgfmt", :exist?
  end
end
