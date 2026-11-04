class Libpointing < Formula
  desc "Provides direct access to HID pointing devices"
  homepage "https://github.com/INRIA/libpointing"
  url "https://github.com/INRIA/libpointing/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "697581d27101c9816f1b19715e7ace85a5345857d65e4eaa82840cf2051435d6"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "python" => :build

  on_linux do
    depends_on "libx11"
    depends_on "libxi"
    depends_on "libxrandr"
    depends_on "systemd"
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "382fc6ed60dbd9d2610702534e63bb179d086a62c68fbeaeebbfe3594aa507e3"
  end

  def install
    # Fix packaging scripts to be compatible with Python 3
    scripts = %w[building-and-packaging/linux/prepare building-and-packaging/mac/prepare]
    inreplace scripts do |s|
      s.gsub! "#!/usr/bin/env python", "#!/usr/bin/env python3"
      s.gsub! ": print >> fd, TEST_PROG\n", ": print(TEST_PROG, file=fd)\n"
      s.gsub!(/print >> makefile, (.*)\n/, "print(\\1, file=makefile)\n")
      s.gsub! "print >> makefile\n", "print(\"\", file=makefile)\n"
    end

    platform = OS.mac? ? "mac" : "linux"
    cd "building-and-packaging/#{platform}" do
      ENV["LIBPOINTING_VERSION"] = version
      system "./prepare"
      subdir = OS.mac? ? version : "dist"
      system "make", "-C", "libpointing-#{subdir}"
      system "make", "-C", "libpointing-#{subdir}", "install", "PREFIX=#{prefix}"
    end
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <pointing/pointing.h>
      #include <iostream>
      int main() {
        std::cout << LIBPOINTING_VER_STRING << " |" ;
        std::list<std::string> schemes = pointing::TransferFunction::schemes() ;
        for (std::list<std::string>::iterator i=schemes.begin(); i!=schemes.end(); ++i) {
          std::cout << " " << (*i) ;
        }
        std::cout << std::endl ;
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lpointing", "-o", "test"
    system "./test"
  end
end
