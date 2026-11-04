class Ansilove < Formula
  desc "ANSI/ASCII art to PNG converter"
  homepage "https://www.ansilove.org"
  url "https://github.com/ansilove/ansilove/releases/download/4.2.2/ansilove-4.2.2.tar.gz"
  sha256 "443e1d8b6d94851cb9563f530b56fb5ef8ffba4b1eda6fd2c3cafaa38adb62d3"
  license "BSD-2-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7d23de84a78e99dffdf37c768968a9de37cebd01bb27554c4f4a89cd65f0824f"
  end

  depends_on "cmake" => :build
  depends_on "libansilove"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "examples/burps/bs-ansilove.ans" => "test.ans"
  end

  test do
    output = shell_output("#{bin}/ansilove -o #{testpath}/output.png #{pkgshare}/test.ans")
    assert_match "Font: 80x25", output
    assert_match "Id: SAUCE v00", output
    assert_match "Tinfos: IBM VGA", output
    assert_path_exists testpath/"output.png"
  end
end
