class Libbladerf < Formula
  desc "USB 3.0 Superspeed Software Defined Radio Source"
  homepage "https://nuand.com/"
  url "https://github.com/Nuand/bladeRF.git",
      tag:      "2025.10",
      revision: "fcf9423325ae49f5fdd2e5b52ab68bfc2576ad47"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later", "MIT"]
  head "https://github.com/Nuand/bladeRF.git", branch: "master"

  # Upstream uses GitHub releases to indicate that a version is released
  # and they may retag a stable version before release, so the `GithubLatest`
  # strategy is necessary.
  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "87437445aff48294e0fad4fce01deac061f96978810534f03c2fd7a3d6cc5dc5"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"
  depends_on "ncurses"

  uses_from_macos "curl"
  uses_from_macos "libedit"

  def install
    ENV.prepend "CFLAGS", "-I#{MacOS.sdk_path}/usr/include/malloc" if OS.mac?
    args = %W[
      -DUDEV_RULES_PATH=#{lib}/udev/rules.d
    ]
    system "cmake", "-S", "host", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"bladeRF-cli", "--version"
  end
end
