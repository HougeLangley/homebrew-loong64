class Openjdk < Formula
  desc "OpenJDK Java Development Kit (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/openjdk-25.0.2.tar.gz"
  sha256 "fd2e7967a4cbb8e019d752f385846a663a163074f6f249bbbed509ddc62744cc"
  version "25.0.2"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    j = Dir["/usr/lib/jvm/*/bin"].first
    Dir["#{j}/*"].each { |t| (bin/File.basename(t)).make_symlink t if File.file?(t) } if j
    jh = Dir["/usr/lib/jvm/*/include"].first
    cp_r Dir["#{jh}/*"], include if jh
    Dir["/usr/lib/jvm/*/lib"].each { |ld| (lib/"jvm").mkpath; Dir["#{ld}/*"].each { |f| (lib/"jvm"/File.basename(f)).make_symlink f } }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
