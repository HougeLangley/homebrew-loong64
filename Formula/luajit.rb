class Luajit < Formula
  desc "Just-In-Time Compiler for Lua (system stub)"
  homepage "https://luajit.org/"
  url "file:///home/houge/infra/srv/stubs/luajit-2.1.0.tar.gz"
  sha256 "97fe2fe83e5546f8d2b405e28e16a4d0608816446ba0aad3cb2c3bd18a8d154a"
  version "2.1.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4ece9b5b9b834c3a080ac9935d7cef055e1b5fe057ec6e06bbce21ee4e3ee256"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    # Bridge system luajit
    %w[luajit luajit-2.1.0-beta3].each do |tool|
      src = "/usr/bin/#{tool}"
      (bin/tool).make_symlink src if File.exist?(src)
    end
    Dir["/usr/lib/libluajit*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    Dir["/usr/include/luajit*"].each { |d| (include/File.basename(d)).make_symlink d if File.directory?(d) }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
