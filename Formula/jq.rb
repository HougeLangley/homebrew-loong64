class Jq < Formula
  desc "Lightweight and flexible command-line JSON processor"
  homepage "https://jqlang.github.io/jq/"
  url "https://github.com/jqlang/jq/releases/download/jq-1.8.2/jq-1.8.2.tar.gz"
  sha256 "71b8d6e8f5fe81f6c6d0d110e3892251f6ce76ed095abd315e26e6e1193af3af"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e907c74adaaa16f9a4371d0d7a07c5bc52664bbdc49413e0373edb7589da3142"
  end

  compatibility_version 1

  livecheck do
    url :stable
    regex(/^(?:jq[._-])?v?(\d+(?:\.\d+)+)$/i)
  end


  head do
    url "https://github.com/jqlang/jq.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "oniguruma"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args,
                          "--disable-silent-rules",
                          "--disable-maintainer-mode"
    system "make", "install"
  end

  test do
    assert_equal "2\n", pipe_output("#{bin}/jq .bar", '{"foo":1, "bar":2}')
  end
end
