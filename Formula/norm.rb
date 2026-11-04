class Norm < Formula
  desc "NACK-Oriented Reliable Multicast"
  homepage "https://www.nrl.navy.mil/itd/ncs/products/norm"
  url "https://github.com/USNavalResearchLaboratory/norm/releases/download/v1.5.9/src-norm-1.5.9.tgz"
  sha256 "ef6d7bbb7b278584e057acefe3bc764d30122e83fa41d41d8211e39f25b6e3fa"
  license "BSD-2-Clause"


  uses_from_macos "python" => :build

  # Fix warning: 'visibility' attribute ignored [-Wignored-attributes]
  # Remove in the next release
  #
  patch do
    url "https://github.com/USNavalResearchLaboratory/norm/commit/476b8bb7eba5a9ad02e094de4dce05a06584f5a0.patch?full_index=1"
    sha256 "08f7cc7002dc1afe6834ec60d4fea5c591f88902d1e76c8c32854a732072ea56"
    type :backport
    resolves "https://github.com/USNavalResearchLaboratory/norm/pull/27"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f63ef6c5d3fe8f75f3cdeb30ce9784f1c1d80905034e8558cefe09b2b73ca94e"
  end

  def install
    system "python3", "./waf", "configure", "--prefix=#{prefix}"
    system "python3", "./waf", "install"

    include.install "include/normApi.h"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <assert.h>
      #include <normApi.h>

      int main()
      {
        NormInstanceHandle i;
        i = NormCreateInstance(false);
        assert(i != NORM_INSTANCE_INVALID);
        NormDestroyInstance(i);
        return 0;
      }
    C
    system ENV.cxx, "test.c", "-L#{lib}", "-lnorm", "-o", "test"
    system "./test"
  end
end
