class Knock < Formula
  desc "Port-knock server"
  homepage "https://github.com/jvinet/knock"
  url "https://github.com/jvinet/knock/releases/download/v0.8/knock-0.8.tar.gz"
  sha256 "698d8c965624ea2ecb1e3df4524ed05afe387f6d20ded1e8a231209ad48169c7"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "45b6a05363c0921deae99c635c04250cea8157e5143e80a0c4a46a62d16f5ae7"
  end

  head do
    url "https://github.com/jvinet/knock.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "libpcap"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"knock", "localhost", "123:tcp"
  end
end
