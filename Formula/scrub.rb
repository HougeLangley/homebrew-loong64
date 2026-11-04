class Scrub < Formula
  desc "Writes patterns on magnetic media to thwart data recovery"
  homepage "https://github.com/chaos/scrub"
  url "https://github.com/chaos/scrub/releases/download/2.6.1/scrub-2.6.1.tar.gz"
  sha256 "43d98d3795bc2de7920efe81ef2c5de4e9ed1f903c35c939a7d65adc416d6cb8"
  license "GPL-2.0-or-later"


  head do
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1738a17ad1b0d24078a0249e4c2681d92b3d5b68b3842252b48ded4aed526c5a"
  end

    url "https://github.com/chaos/scrub.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    if build.head?
      system "./autogen.sh"
    elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      # Help old config scripts identify arm64 linux
      args << "--build=aarch64-unknown-linux-gnu"
      args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
    end

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    path = testpath/"foo.txt"
    path.write "foo"

    output = shell_output("#{bin}/scrub -r -p dod #{path}")
    assert_match "scrubbing #{path}", output
    refute_path_exists path
  end
end
