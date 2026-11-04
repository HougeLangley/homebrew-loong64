class Dynamips < Formula
  desc "Cisco 7200/3600/3725/3745/2600/1700 Router Emulator"
  homepage "https://github.com/GNS3/dynamips"
  url "https://github.com/GNS3/dynamips/archive/refs/tags/v0.2.25.tar.gz"
  sha256 "af8e5c24906382b041e0f86f8e4290cff78e8ab4f3aa6097f9f7d666d53368bf"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f571a91be30f7ad33d8d7603c083a68ccde3a3d05bba9079793fd78f7827cb77"
  end

  depends_on "cmake" => :build

  uses_from_macos "libpcap"

  on_macos do
    # https://github.com/GNS3/dynamips/issues/142
    depends_on "libelf" => :build
  end

  on_linux do
    depends_on "elfutils"
  end

  deny_network_access!

  def install
    cmake_args = ["-DANY_COMPILER=1"]
    cmake_args << if OS.mac?
      "-DLIBELF_INCLUDE_DIRS=#{formula_opt_include("libelf")}/libelf"
    else
      "-DLIBELF_INCLUDE_DIRS=#{formula_opt_include("elfutils")}"
    end

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"dynamips", "-e"
  end
end
