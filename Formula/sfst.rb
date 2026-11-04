class Sfst < Formula
  desc "Toolbox for morphological analysers and other FST-based tools"
  homepage "https://www.cis.uni-muenchen.de/~schmid/tools/SFST/"
  url "https://www.cis.uni-muenchen.de/~schmid/tools/SFST/data/SFST-1.4.7g.zip"
  sha256 "5f3ab2d8190dc931813b5ba3cf94c72013cce7bf03e16d7fb2eda86bd99ce944"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "97e17c3076b1c7829115e96f4a56020b3ba7ee217bb95b45e3db04e98732be9c"
  end

  livecheck do
    url :homepage
    regex(%r{href=.*?data/SFST[._-]v?(\d+(?:\.\d+)+[a-z]*)\.[tz]}i)
  end


  uses_from_macos "flex" => :build

  on_linux do
    depends_on "readline"
  end


  def install
    cd "src" do
      system "make"
      system "make", "DESTDIR=#{prefix}/", "install"
      system "make", "DESTDIR=#{share}/", "maninstall"
    end
  end

  test do
    require "open3"

    (testpath/"foo.fst").write "Hello"
    system bin/"fst-compiler", "foo.fst", "foo.a"
    assert_path_exists testpath/"foo.a", "Foo.a should exist but does not!"

    Open3.popen3("#{bin}/fst-mor", "foo.a") do |stdin, stdout, _|
      stdin.write("Hello")
      stdin.close
      expected_output = "Hello\n"

      # On Linux, the prompts are also captured in the output
      expected_output = "analyze> Hello\n" + expected_output + "analyze> " if OS.linux?

      actual_output = stdout.read
      assert_equal expected_output, actual_output
    end
  end
end
