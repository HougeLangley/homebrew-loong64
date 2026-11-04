class Bmake < Formula
  desc "Portable version of NetBSD make(1)"
  homepage "https://www.crufty.net/help/sjg/bmake.html"
  url "https://www.crufty.net/ftp/pub/sjg/bmake-20260912.tar.gz"
  sha256 "b6bd32964cbe451be2838822c9d200b7c7e76a2a5947c03feb71dc6bd72988bd"
  license "BSD-3-Clause"

  livecheck do
    url "https://www.crufty.net/ftp/pub/sjg/"
    regex(/href=.*?bmake[._-]v?(\d{6,8})\.t/i)
  end


  uses_from_macos "bc-gh" => :build

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8f2d916a60a70091b20ecb45a9b083bd9a3a7b2e5c57954bdbb0574d6c425f04"
  end

  def install
    # -DWITHOUT_PROG_LINK means "don't symlink as bmake-VERSION."
    # shell-ksh test segfaults since macOS 11.
    broken_tests = %w[shell-ksh]
    if OS.linux?
      # The sandbox denies reading "/", which these unit tests and "bmake -r -m /" need
      ENV["MK_AUTO_OBJ"] = "no"
      broken_tests += %w[dir opt-chdir opt-where-am-i varname-dot-curdir varname-dot-path]
    end
    ENV["BROKEN_TESTS"] = broken_tests.join(" ")

    args = ["--prefix=#{prefix}", "-DWITHOUT_PROG_LINK", "--install"]
    system "sh", "boot-strap", *args
  end

  test do
    (testpath/"Makefile").write <<~MAKE
      all: hello

      hello:
      	@echo 'Test successful.'

      clean:
      	rm -rf Makefile
    MAKE
    system bin/"bmake"
    system bin/"bmake", "clean"
  end
end
