class Boost < Formula
  desc "Boost C++ libraries (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/boost-1.91.0.tar.gz"
  sha256 "fd2e7967a4cbb8e019d752f385846a663a163074f6f249bbbed509ddc62744cc"
  version "1.91.0"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    cp_r "/usr/include/boost", include/"boost" if Dir.exist?("/usr/include/boost")
    Dir["/usr/lib/libboost_*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
