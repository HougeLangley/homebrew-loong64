class ActivemqCpp < Formula
  desc "C++ API for message brokers such as Apache ActiveMQ"
  homepage "https://activemq.apache.org/components/cms/"
  url "https://www.apache.org/dyn/closer.lua?path=activemq/activemq-cpp/3.9.5/activemq-cpp-library-3.9.5-src.tar.bz2"
  mirror "https://archive.apache.org/dist/activemq/activemq-cpp/3.9.5/activemq-cpp-library-3.9.5-src.tar.bz2"
  sha256 "6bd794818ae5b5567dbdaeb30f0508cc7d03808a4b04e0d24695b2501ba70c15"
  license "Apache-2.0"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d7ce5896d2adeda3ce31f1b694b21f89c951c5bf79c74609a8140f33f212f89e"
  end

  revision 2


  depends_on "pkgconf" => :build
  depends_on "apr"
  depends_on "openssl@4"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  # Backport commit which allows us to build with OpenSSL 4:
  # https://github.com/apache/activemq-cpp/commit/9c4df93026a777a86f9c886b538b454b4c32ba4e
  # This uses a local patch to drop README.txt and RPM spec diff that don't exist in tarball.
  patch :p2 do
    file "Patches/activemq-cpp/9c4df93026a777a86f9c886b538b454b4c32ba4e.diff"
    type :backport
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"activemqcpp-config", "--version"
  end
end
