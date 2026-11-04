class Aften < Formula
  desc "Audio encoder which generates ATSC A/52 compressed audio streams"
  homepage "https://aften.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/aften/aften/0.0.8/aften-0.0.8.tar.bz2"
  sha256 "87cc847233bb92fbd5bed49e2cdd6932bb58504aeaefbfd20ecfbeb9532f0c0a"
  license "LGPL-2.1-or-later"

  # Aften has moved from a version scheme like 0.07 to 0.0.8. We restrict
  # matching to versions with three parts, since a version like 0.07 is parsed
  # as 0.7 and seen as newer than 0.0.8.
  livecheck do
    url :stable
    regex(%r{url=.*?/aften[._-]v?(\d+(?:\.\d+){2,})\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8982a958e591594d826cbc14c6af339b575e12b741318b766a2c9bf25a662f1e"
  end

  depends_on "cmake" => :build

  resource "sample_wav" do
    url "https://www.mediacollege.com/audio/tone/files/1kHz_44100Hz_16bit_05sec.wav"
    sha256 "949dd8ef74db1793ac6174b8d38b1c8e4c4e10fb3ffe7a15b4941fa0f1fbdc20"
  end

  # The ToT actually compiles fine, but there's no official release made from that changeset.
  # So fix the Apple Silicon compile issues.
  # https://sourceforge.net/p/aften/code/ci/dca9c03930d669233258c114e914a01f7c0aeb05/
  patch do
    file "Patches/aften/dca9c03930d669233258c114e914a01f7c0aeb05.patch"
    type :backport
  end

  deny_network_access!

  def install
    # Fix build with CMake 4.0+.
    inreplace "CMakeLists.txt",
              "CMAKE_MINIMUM_REQUIRED(VERSION 2.4)",
              "CMAKE_MINIMUM_REQUIRED(VERSION 3.10)"

    mkdir "default" do
      system "cmake", "-DSHARED=ON", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    resource("sample_wav").stage testpath
    system bin/"aften", testpath/"1kHz_44100Hz_16bit_05sec.wav", "sample.ac3"
  end
end
