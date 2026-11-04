class Bcrypt < Formula
  desc "Cross platform file encryption utility using blowfish"
  homepage "https://bcrypt.sourceforge.net/"
  url "https://bcrypt.sourceforge.net/bcrypt-1.1.tar.gz"
  sha256 "b9c1a7c0996a305465135b90123b0c63adbb5fa7c47a24b3f347deb2696d417d"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?bcrypt[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9d24e18915f4abb7fc4e07735ec6191ed4236e90af41d675c274b7e4a7d63e97"
  end

  def install
    system "make", "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=-lz"
    bin.install "bcrypt"
    man1.install Utils::Gzip.compress("bcrypt.1")
  end

  test do
    (testpath/"test.txt").write("Hello World!")
    pipe_output("#{bin}/bcrypt -r test.txt", "12345678\n12345678\n", 0)
    mv "test.txt.bfe", "test.out.txt.bfe"
    pipe_output("#{bin}/bcrypt -r test.out.txt.bfe", "12345678\n", 0)
    assert_equal File.read("test.txt"), File.read("test.out.txt")
  end
end
