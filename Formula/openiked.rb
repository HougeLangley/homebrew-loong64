class Openiked < Formula
  desc "IKEv2 daemon - portable version of OpenBSD iked"
  homepage "https://openiked.org"
  url "https://cdn.openbsd.org/pub/OpenBSD/OpenIKED/openiked-7.4.tar.gz"
  mirror "https://mirror.edgecast.com/pub/OpenBSD/OpenIKED/openiked-7.4.tar.gz"
  sha256 "19b72b48080240c3eff585f5cbcf6aa7b5734192ad8bc6677ae64a455074358a"
  license "ISC"
  revision 1

  livecheck do
    url "https://cdn.openbsd.org/pub/OpenBSD/OpenIKED/"
    regex(/href=.*?openiked[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bfad45095f2c9c86a58b1b362d9ec7da1e17b786a442762814fe586835f4a001"
  end

  depends_on "cmake" => :build
  depends_on "libevent"
  depends_on "openssl@4"

  uses_from_macos "bison"

  def install
    system "cmake", "-S", ".", "-B", "build",
                         "-DHOMEBREW=true",
                         "-DCMAKE_INSTALL_SYSCONFDIR=#{etc}",
                         "-DCMAKE_INSTALL_MANDIR=#{man}",
                         *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    libexec.install "build/regress/dh/dhtest"
  end

  service do
    run opt_sbin/"iked"
    keep_alive true
    require_root true
    working_dir etc
  end

  def caveats
    <<~EOS
      config file can be found here:
        #{etc}/iked.conf

      necessary files for configuration can be found here:
        #{etc}/iked/
    EOS
  end

  test do
    system sbin/"iked", "-V"
    system libexec/"dhtest"
  end
end
