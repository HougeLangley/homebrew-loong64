class Sshtrix < Formula
  desc "SSH login cracker"
  homepage "https://nullsecurity.net/tools/cracker.html"
  url "https://github.com/nullsecuritynet/tools/raw/main/cracker/sshtrix/release/sshtrix-0.0.3.tar.gz"
  sha256 "30d1d69c1cac92836e74b8f7d0dc9d839665b4994201306c72e9929bee32e2e0"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?sshtrix[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "19b2d68f600c0c9cc480bcdd62b8da1c42f8a00c8670b6e0f0f734e45e59a5ad"
  end

  depends_on "libssh"

  def install
    bin.mkpath
    system "make", "sshtrix", "CC=#{ENV.cc}"
    system "make", "DISTDIR=#{prefix}", "install"
  end

  test do
    system bin/"sshtrix", "-V"
    system bin/"sshtrix", "-O"
  end
end
