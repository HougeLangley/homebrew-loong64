class Epsilon < Formula
  desc "Powerful wavelet image compressor"
  homepage "https://sourceforge.net/projects/epsilon-project/"
  url "https://downloads.sourceforge.net/project/epsilon-project/epsilon/0.9.2/epsilon-0.9.2.tar.gz"
  sha256 "5421a15969d4d7af0ac0a11d519ba8d1d2147dc28d8c062bf0c52f3a0d4c54c4"
  license all_of: [
    "BSD-3-Clause",
    any_of: ["GPL-3.0-or-later", "LGPL-3.0-or-later"],
  ]

  livecheck do
    url :stable
    regex(%r{url=.*?/epsilon[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a4cf3eb9afbb0d6425b7a9b7e9256ecdf6af7a3e71ab929d7d72f04189d4350d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "popt"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # None of our patches apply, so regenerate `configure` to fix the `-flat_namespace` bug.
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"epsilon", "--version"
  end
end
