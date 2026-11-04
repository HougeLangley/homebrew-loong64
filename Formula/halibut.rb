class Halibut < Formula
  desc "Yet another free document preparation system"
  homepage "https://www.chiark.greenend.org.uk/~sgtatham/halibut/"
  url "https://www.chiark.greenend.org.uk/~sgtatham/halibut/halibut-1.3/halibut-1.3.tar.gz"
  sha256 "aaa0f7696f17f74f42d97d0880aa088f5d68ed3079f3ed15d13b6e74909d3132"
  license all_of: ["MIT", "APAFML"]
  head "https://git.tartarus.org/simon/halibut.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?halibut[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3464119352d5c18b69dd5f9fe09547ba9930cfed8192e4e669e2dab93c00d111"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"sample.but").write("Hello, world!")
    system bin/"halibut", "--html=sample.html", "sample.but"

    assert_match("<p>\nHello, world!\n</p>",
                 (testpath/"sample.html").read)
  end
end
