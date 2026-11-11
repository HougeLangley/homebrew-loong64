class Libcec < Formula
  desc "Control devices with TV remote control and HDMI cabling"
  homepage "https://libcec.pulse-eight.com/"
  url "https://github.com/Pulse-Eight/libcec/archive/refs/tags/libcec-8.1.7.tar.gz"
  sha256 "e4ac4d1dd3559cf83189d29ab40fc5537b5a2beceb82916ef173dac7e50dbfa0"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "174203f0caf2da514c4b4956532581fbee00f702288f714100512fb7e94b8016"
  end

  depends_on "cmake" => :build

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # Upstream's CI has no SWIG/Python dev env, so the pycec wrapper is off.
    # Our prefix ships swig+python, causing CMake to autodetect pycec whose
    # SWIG wrapper then fails because Homebrew's superenv strips Python's
    # include path. Disable it explicitly to match the upstream bottle build.
    #
    # CMake also auto-detects xrandr against brew's libXrandr while this
    # formula (like upstream core) does not declare X deps. The resulting
    # libcec.so.8 then loads brew's X11 chain through the keg RUNPATH and
    # cec-client --list-devices aborts with "free(): invalid pointer"
    # (verified: forcing system libs via LD_LIBRARY_PATH fixes it). Turn the
    # optional randr EDID probe off for a headless, dependency-clean build.
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
           "-DCMAKE_INSTALL_RPATH=#{rpath}",
           "-DSKIP_PYTHON_WRAPPER=ON",
           "-DHAVE_RANDR=OFF"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "libCEC version: #{version}", shell_output("#{bin}/cec-client --list-devices")
  end
end
