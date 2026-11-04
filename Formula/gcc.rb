class Gcc < Formula
  desc "GNU compiler collection (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/gcc-16.2.0.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "16.2.0"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    %w[gcc g++ cpp gcov gfortran].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"gcc").mkpath
    cp_r Dir["/usr/lib/gcc/*"], lib/"gcc" if Dir.exist?("/usr/lib/gcc")
    (include/"c++").mkpath
    cp_r Dir["/usr/include/c++/*"], include/"c++" if Dir.exist?("/usr/include/c++")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
