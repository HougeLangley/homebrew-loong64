class Passwdqc < Formula
  desc "Password/passphrase strength checking and enforcement toolset"
  homepage "https://www.openwall.com/passwdqc/"
  url "https://www.openwall.com/passwdqc/passwdqc-2.1.0.tar.gz"
  sha256 "52fa12271104e74126145c6224b22b4a8dd32cc47de04c1e9fb8f348340df4d2"
  license "0BSD"

  livecheck do
    url :homepage
    regex(/href=["']?passwdqc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "libxcrypt"

  on_linux do
    depends_on "linux-pam"
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "55e2f2ff2368791016ba4c35d7679fa74fcd1ca47e6a5ab12d61c570ce006bb7"
  end

  def install
    args = %W[
      BINDIR=#{bin}
      CC=#{ENV.cc}
      CONFDIR=#{etc}
      DEVEL_LIBDIR=#{lib}
      INCLUDEDIR=#{include}
      MANDIR=#{man}
      PREFIX=#{prefix}
      SHARED_LIBDIR=#{lib}
    ]

    args << if OS.mac?
      "SECUREDIR_DARWIN=#{prefix}/pam"
    else
      "SECUREDIR=#{prefix}/pam"
    end

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    args << "CFLAGS=#{ENV.cflags}" if ENV.cflags.present?

    system "make", *args
    system "make", "install", *args
  end

  test do
    pipe_output("#{bin}/pwqcheck -1", shell_output("#{bin}/pwqgen"))
  end
end
