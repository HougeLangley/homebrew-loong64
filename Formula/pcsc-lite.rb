class PcscLite < Formula
  desc "Middleware to access a smart card using SCard API"
  homepage "https://pcsclite.apdu.fr/"
  url "https://pcsclite.apdu.fr/files/pcsc-lite-2.5.3.tar.xz"
  sha256 "fe2bb733ecf95e52768907eb00da9f9f3daf180960283e514a05dcc090afa3bd"
  license all_of: [
    "BSD-3-Clause",
    "BSD-2-Clause",     # src/auth.*
    "GPL-3.0-or-later", # src/spy/ (libpcscspy, pcsc-spy)
    "ISC",              # src/simclist.*
  ]

  livecheck do
    url "https://pcsclite.apdu.fr/files/"
    regex(/href=.*?pcsc-lite[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  keg_only :shadowed_by_macos, "macOS provides PCSC.framework"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "618d59d9943656866ac426896ee45bd5b7a9e026c1ea0fc0a40ce483ae111f5f"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "flex" => :build

  def install
    args = %W[
      -Dlibsystemd=false
      -Dlibudev=false
      -Dpolkit=false
      -Dipcdir=#{var}/run
      -Dsysconfdir=#{etc}
      -Dsbindir=#{sbin}
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system sbin/"pcscd", "--version"
  end
end
