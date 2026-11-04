class Ftxui < Formula
  desc "C++ Functional Terminal User Interface"
  homepage "https://arthursonzogni.github.io/FTXUI/"
  url "https://github.com/ArthurSonzogni/FTXUI/releases/download/v7.0.3/source.tar.gz"
  sha256 "be506d647bf6eed2e7927f99ea080bcccff0938d9a35617756161d5b76df8b8a"
  license "MIT"
  head "https://github.com/ArthurSonzogni/FTXUI.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9b05225d5f049950e477d057684f55a46442c06f3050b0273cb00a9d7b56cb70"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DFTXUI_BUILD_DOCS=OFF
      -DFTXUI_BUILD_EXAMPLES=OFF
      -DFTXUI_BUILD_TESTS=OFF
      -DFTXUI_QUIET=ON
      -DFTXUI_ENABLE_COVERAGE=OFF
    ]

    system "cmake", "-S", ".", "-B", "builddir", *args, *std_cmake_args
    system "cmake", "--build", "builddir"
    system "cmake", "--install", "builddir"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <ftxui/dom/elements.hpp>
      int main() {
        using namespace ftxui;
        auto summary = [&] {
        auto content = vbox({
          hbox({text(L"- done:   "), text(L"3") | bold}) | color(Color::Green),});
          return window(text(L" Summary "), content);
        };
        return EXIT_SUCCESS;
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++17", "-o", "test"
    system "./test"
  end
end
