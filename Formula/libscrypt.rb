class Libscrypt < Formula
  desc "Library for scrypt"
  homepage "https://github.com/technion/libscrypt"
  url "https://github.com/technion/libscrypt/archive/refs/tags/v1.22.tar.gz"
  sha256 "a2d30ea16e6d288772791de68be56153965fe4fd4bcd787777618b8048708936"
  license "BSD-2-Clause"


  # Backport fix for aliasing violations
  patch do
    url "https://github.com/technion/libscrypt/commit/7b574b9c517a3d1f9bd0e265a5f287155293cb85.patch?full_index=1"
    sha256 "5f3b4eaef826191318b57d1c0fe2889d76d18bf17746af2ba5417ccf27ec039f"
    type :backport
    resolves "https://github.com/technion/libscrypt/pull/62"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c0563a786655e0c7da2976cb5abc3593d0cba295a8719d0c40f7c917f0ab022e"
  end

  def install
    args = ["PREFIX=#{prefix}"]
    install_target = "install"

    if OS.mac?
      args += %w[CFLAGS_EXTRA=-fstack-protector LDFLAGS= LDFLAGS_EXTRA=]
      install_target << "-osx"
    end

    system "make", "check", *args
    system "make", install_target, *args
    system "make", "install-static", *args

    return if OS.mac?

    prefix.install "libscrypt.version"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libscrypt.h>
      int main(void) {
        char buf[SCRYPT_MCF_LEN];
        libscrypt_hash(buf, "Hello, Homebrew!", SCRYPT_N, SCRYPT_r, SCRYPT_p);
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lscrypt", "-o", "test"
    system "./test"
  end
end
