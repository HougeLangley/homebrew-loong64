class Samurai < Formula
  desc "Ninja-compatible build tool written in C"
  homepage "https://github.com/michaelforney/samurai"
  url "https://github.com/michaelforney/samurai/releases/download/1.3/samurai-1.3.tar.gz"
  sha256 "1bc020a9e133432df51911ac71cc34322f828934d9a2282ba2916d88c15976af"
  license "Apache-2.0"
  head "https://github.com/michaelforney/samurai.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1668cbf8af336d109dd40f965938b40e508578045bfba984a86627355971afae"
  end

  def install
    args = ["PREFIX=#{prefix}"]
    args << "LDLIBS=" if OS.mac?
    system "make", "install", *args
  end

  test do
    (testpath/"build.ninja").write <<~NINJA
      rule cc
        command = #{ENV.cc} $in -o $out
      build hello: cc hello.c
    NINJA
    (testpath/"hello.c").write <<~C
      #include <stdio.h>
      int main() {
        puts("Hello, world!");
        return 0;
      }
    C
    system bin/"samu"
    assert_match "Hello, world!", shell_output("./hello")
  end
end
