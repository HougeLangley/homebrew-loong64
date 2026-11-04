class Libhttpserver < Formula
  desc "C++ library of embedded Rest HTTP server"
  homepage "https://github.com/etr/libhttpserver"
  url "https://github.com/etr/libhttpserver/releases/download/2.0.1/libhttpserver-2.0.1.tar.gz"
  sha256 "767716a689b5078a9e6ad4e6dc5c2708a50c79f195fce599dd80e35566c8f64a"
  license "LGPL-2.1-or-later"


  head do
    url "https://github.com/etr/libhttpserver.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fd701fa2664e51617b2b882ab03e5dd98a1de36fde0db4221fba1b71cc7c37c2"
  end

  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "libmicrohttpd"

  uses_from_macos "curl" => :test

  allow_network_access! :test

  def install
    system "./bootstrap" if build.head?
    mkdir "build" do
      system "../configure", "--disable-silent-rules", *std_configure_args
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    port = free_port

    cp pkgshare/"examples/hello_world.cpp", testpath
    inreplace "hello_world.cpp", "create_webserver(8080)", "create_webserver(#{port})"

    system ENV.cxx, "hello_world.cpp",
      "-std=c++20", "-o", "hello_world", "-L#{lib}", "-lhttpserver", "-lcurl"

    pid = spawn "./hello_world"

    assert_match "Hello, World!",
                 shell_output("curl --silent --show-error --retry 5 --retry-connrefused http://127.0.0.1:#{port}/hello")
  ensure
    Process.kill "TERM", pid
    Process.wait pid
  end
end
