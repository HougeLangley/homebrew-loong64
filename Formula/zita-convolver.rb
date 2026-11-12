class ZitaConvolver < Formula
  desc "Fast, partitioned convolution engine library"
  homepage "https://kokkinizita.linuxaudio.org/linuxaudio/"
  url "https://kokkinizita.linuxaudio.org/linuxaudio/downloads/zita-convolver-4.0.3.tar.bz2"
  sha256 "9aa11484fb30b4e6ef00c8a3281eebcfad9221e3937b1beb5fe21b748d89325f"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://kokkinizita.linuxaudio.org/linuxaudio/downloads/index.html"
    regex(/href=.*?zita-convolver[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9387eeb71704390615bb76076f2b821305c62f06a66f3d5bbaa8d03af99c333e"
  end

  depends_on "fftw"

  deny_network_access!

  def install
    cd "source" do
      inreplace "Makefile", "-Wl,-soname,", "-Wl,-install_name," if OS.mac?
      inreplace "Makefile", "ldconfig", "ln -sf $(ZITA-CONVOLVER_MIN) $(DESTDIR)$(LIBDIR)/$(ZITA-CONVOLVER_MAJ)"
      system "make", "install", "PREFIX=#{prefix}", "SUFFIX="
    end
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <zita-convolver.h>

      int main() {
        return zita_convolver_major_version () != ZITA_CONVOLVER_MAJOR_VERSION;
      }
    CPP
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lzita-convolver", "-o", "test"
    system "./test"
  end
end
