class Spin < Formula
  desc "Efficient verification tool of multi-threaded software"
  homepage "https://spinroot.com/spin/whatispin.html"
  url "https://github.com/nimble-code/Spin/archive/refs/tags/version-6.5.2.tar.gz"
  sha256 "e46a3bd308c4cd213cc466a8aaecfd5cedc02241190f3cb9a1d1b87e5f37080a"
  license "BSD-3-Clause"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a996db031f84b5065b9cbbe9f1b94f297ef9a1b13fbdbaa8a35975a11caf067f"
  end


  uses_from_macos "bison" => :build


  def install
    cd "Src" do
      system "make"
      bin.install "spin"
    end

    man1.install "Man/spin.1"
  end

  test do
    (testpath/"test.pml").write <<~PML
      mtype = { ruby, python };
      mtype = { golang, rust };
      mtype language = ruby;

      active proctype P() {
        do
        :: if
          :: language == ruby -> language = golang
          :: language == python -> language = rust
          fi;
          printf("language is %e", language)
        od
      }
    PML
    output = shell_output("#{bin}/spin #{testpath}/test.pml")
    assert_match "language is golang", output
  end
end
