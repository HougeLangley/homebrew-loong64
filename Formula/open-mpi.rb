class OpenMpi < Formula
  desc "Message passing interface library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/open-mpi-4.1.6.tar.gz"
  sha256 "67a7f9070adc079c27791366db1ee01799be7b6a872d23169aba17023a6dde31"
  version "4.1.6"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    %w[mpicc mpicxx mpirun mpiexec].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    Dir["/usr/lib/libmpi*.so*", "/usr/lib/libopen-rte*.so*", "/usr/lib/libopen-pal*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    (include/"mpi").mkpath
    cp_r Dir["/usr/include/mpi/*"], include/"mpi" if Dir.exist?("/usr/include/mpi")
    (include/"mpi.h").make_symlink "/usr/include/mpi.h" if File.exist?("/usr/include/mpi.h")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
