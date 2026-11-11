class Atomicparsley < Formula
  desc "MPEG-4 command-line tool"
  homepage "https://github.com/wez/atomicparsley"
  url "https://github.com/wez/atomicparsley/archive/refs/tags/20240608.083822.1ed9031.tar.gz"
  version "20240608.083822.1ed9031"
  sha256 "5bc9ac931a637ced65543094fa02f50dde74daae6c8800a63805719d65e5145e"
  license "GPL-2.0-or-later"
  version_scheme 1
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "75621f4576f08b9bf8785653d39c957bd952920aebfb496d0e2eb40a77f75c7c"
  end

  head "https://github.com/wez/atomicparsley.git", branch: "master"



  depends_on "cmake" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/AtomicParsley"
  end

  test do
    cp test_fixtures("test.m4a"), testpath/"file.m4a"

    system bin/"AtomicParsley", testpath/"file.m4a", "--artist", "Homebrew", "--overWrite"
    output = shell_output("#{bin}/AtomicParsley file.m4a --textdata")
    assert_match "Homebrew", output
  end
end
