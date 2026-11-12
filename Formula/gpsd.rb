class Gpsd < Formula
  desc "Global Positioning System (GPS) daemon"
  homepage "https://gpsd.gitlab.io/gpsd/"
  url "https://download.savannah.gnu.org/releases/gpsd/gpsd-3.27.5.tar.xz"
  mirror "https://download-mirror.savannah.gnu.org/releases/gpsd/gpsd-3.27.5.tar.xz"
  sha256 "dc4a62bad835282bae788772bc7cc8f8bec4c7a48e8dceeb37477a89091c4656"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a3f71a457cc8c1b4d4283fa283b532da6008ce253f664c4948926cc1c8a3e754"
  end

  head "https://gitlab.com/gpsd/gpsd.git", branch: "master"

  livecheck do
    url "https://download.savannah.gnu.org/releases/gpsd/"
    regex(/href=.*?gpsd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "asciidoctor" => :build
  depends_on "scons" => :build

  uses_from_macos "ncurses"

  # SCons forces stdenv, whose versioned-GCC CPU flag map lacks LoongArch.
  if OS.linux? && Hardware::CPU.arch == :loongarch64
    Hardware::CPU.singleton_class.prepend(Module.new do
      def optimization_flags
        super.merge(loongarch64: Hardware::CPU.arch_flag(:loongarch64))
      end
    end)
  end

  def install
    if OS.linux?
      ncurses = Formula["ncurses"]

      ENV.append "CFLAGS", "-I#{ncurses.opt_include}"
      ENV.append "LDFLAGS", "-L#{ncurses.opt_lib} -Wl,-rpath,#{ncurses.opt_lib}"
    end

    system Formula["scons"].opt_bin/"scons", "chrpath=False", "python=False", "strip=False", "prefix=#{prefix}/"
    system Formula["scons"].opt_bin/"scons", "install"
  end

  def caveats
    <<~EOS
      gpsd does not automatically detect GPS device addresses. Once started, you
      need to force it to connect to your GPS:

        GPSD_SOCKET="#{var}/gpsd.sock" #{sbin}/gpsdctl add /dev/tty.usbserial-XYZ
    EOS
  end

  service do
    run [opt_sbin/"gpsd", "-N", "-F", var/"gpsd.sock"]
    keep_alive true
    error_log_path var/"log/gpsd.log"
    log_path var/"log/gpsd.log"
    working_dir HOMEBREW_PREFIX
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/gpsd -V")
  end
end
