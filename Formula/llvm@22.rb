class LlvmAT22 < Formula
  desc "Next-gen compiler infrastructure (system stub)"
  homepage "https://llvm.org/"
  url "file:///home/houge/infra/srv/stubs/llvm-22.1.8.tar.gz"
  sha256 "e51899af047a3e193564cb872c28bc5bb62bbaa1377cdf35ccf4b38fd980cc92"
  version "22.1.8"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    src = "/usr/lib/llvm-22"
    cp_r Dir["#{src}/bin/*"], bin if Dir.exist?("#{src}/bin")
    cp_r Dir["#{src}/include/*"], include if Dir.exist?("#{src}/include")
    cp_r Dir["#{src}/lib/*"], lib if Dir.exist?("#{src}/lib")
    cp_r Dir["#{src}/share/*"], share if Dir.exist?("#{src}/share")
    (prefix/"system_stub").write "provided by AOSC OS llvm 22.1.8\n"
  end

  test do
    assert_predicate bin/"llvm-config", :exist?
  end
end
