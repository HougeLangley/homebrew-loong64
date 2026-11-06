class Pdsh < Formula
  desc "Efficient rsh-like utility, for using hosts in parallel"
  homepage "https://github.com/chaos/pdsh"
  url "https://github.com/chaos/pdsh/releases/download/pdsh-2.36/pdsh-2.36.tar.gz"
  sha256 "a661095ce51dd5fb05e398cf5d0e1d63157123958441f6d3512bcf1a7d25c517"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d0b8f124c48fda7ddc9667cb0b69f08e7e97ef1f9de00f9e6c471aa446e5ee0a"
  end

  head "https://github.com/chaos/pdsh.git", branch: "master"


  depends_on "readline"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
      --with-nodeupdown
      --with-readline
      --with-ssh
      --with-dshgroups
      --with-netgroup
      --with-slurm
      --without-rsh
      --without-xcpu
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"
  end

  test do
    system bin/"pdsh", "-V"
  end
end
