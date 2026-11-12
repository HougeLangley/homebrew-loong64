class Atf < Formula
  desc "Automated testing framework"
  homepage "https://github.com/freebsd/atf"
  url "https://github.com/freebsd/atf/releases/download/atf-0.26/atf-0.26.tar.gz"
  sha256 "bae70930bef565faacb95b10e5673601df0d7f25db720cc735060d115c92ee73"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "aa7e7059c3dd1983b88b707333a950cd9f148732321462b5521862023020b293"
  end

  head "https://github.com/freebsd/atf.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "glibtoolize", "--force", "--install"
    system "autoreconf", "--force", "--install", "--verbose"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.sh").write <<~SHELL
      #!/usr/bin/env atf-sh
      echo test
      exit 0
    SHELL
    system "bash", "test.sh"
  end
end
