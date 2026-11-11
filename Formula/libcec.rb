class Libcec < Formula
  desc "Control devices with TV remote control and HDMI cabling"
  homepage "https://libcec.pulse-eight.com/"
  url "https://github.com/Pulse-Eight/libcec/archive/refs/tags/libcec-8.1.7.tar.gz"
  sha256 "e4ac4d1dd3559cf83189d29ab40fc5537b5a2beceb82916ef173dac7e50dbfa0"
  license "GPL-2.0-or-later"



  depends_on "cmake" => :build

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # Upstream's CI has no SWIG/Python dev env, so the pycec wrapper is off.
    # Our prefix ships swig+python, causing CMake to autodetect pycec whose
    # SWIG wrapper then fails because Homebrew's superenv strips Python's
    # include path. Disable it explicitly to match the upstream bottle build.
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
           "-DCMAKE_INSTALL_RPATH=#{rpath}", "-DSKIP_PYTHON_WRAPPER=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "libCEC version: #{version}", shell_output("#{bin}/cec-client --list-devices")
  end
end
