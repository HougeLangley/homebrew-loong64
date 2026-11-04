class Ldpl < Formula
  desc "COBOL-like programming language that compiles to C++"
  homepage "https://www.ldpl-lang.org/"
  url "https://github.com/Lartu/ldpl/archive/refs/tags/LDPL-5.1.0.tar.gz"
  sha256 "f61c0a8a3405965a7ee168da3ecf754b600de5a1c89208ae437ffba8658b2701"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1fe0dc8b062e61a6f107b3270df52749af12c4a27cf96f63bc25b0d14fd52a18"
  end

  def install
    # Workaround for the error: '/usr/local/lib/ldpl/ldpl_lib.cpp' file not found in tests
    inreplace "src/ldpl.cpp", "LDPLLIBLOCATION", "\"#{lib}/ldpl\""

    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"hello.ldpl").write <<~EOS
      PROCEDURE:
      display "Hello World!" crlf
    EOS
    system bin/"ldpl", "hello.ldpl", "-o=hello"
    assert_match "Hello World!", shell_output("./hello")
  end
end
