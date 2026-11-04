class Nsync < Formula
  desc "C library that exports various synchronization primitives"
  homepage "https://github.com/google/nsync"
  url "https://github.com/google/nsync/archive/refs/tags/1.30.0.tar.gz"
  sha256 "883a0b3f8ffc1950670425df3453c127c1a3f6ed997719ca1bbe7f474235b6cc"
  license "Apache-2.0"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f8fed57fd6f7d18f7d088c9e93095894abbae665ae4d03b035eb88ceffb37b29"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DNSYNC_ENABLE_TESTS=OFF
    ]
    system "cmake", "-S", ".", "-B", "_build", *args, *std_cmake_args
    system "cmake", "--build", "_build"
    system "cmake", "--install", "_build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <nsync.h>
      #include <stdio.h>

      int main() {
        nsync_mu mu;
        nsync_mu_init(&mu);
        nsync_mu_lock(&mu);
        nsync_mu_unlock(&mu);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-lnsync", "-o", "test"
    system "./test"
  end
end
