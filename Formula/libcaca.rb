class Libcaca < Formula
  desc "Convert pixel information into colored ASCII art"
  homepage "http://caca.zoy.org/wiki/libcaca"
  url "https://github.com/cacalabs/libcaca/releases/download/v0.99.beta20/libcaca-0.99.beta20.tar.bz2"
  sha256 "ff9aa641af180a59acedc7fc9e663543fb397ff758b5122093158fd628125ac1"
  license "WTFPL"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "216d16929b1d8ee8bd6e841e8187044aed345c21248ab32ab9ceb139ecda29b2"
  end

  compatibility_version 1

  # Need an explicit livecheck as only beta versions are available
  livecheck do
    url :stable
  end


  head do
    url "https://github.com/cacalabs/libcaca.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "imlib2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./bootstrap" if build.head?

    args = %w[
      --disable-cocoa
      --disable-csharp
      --disable-doc
      --disable-java
      --disable-python
      --disable-ruby
      --disable-slang
      --disable-x11
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    ENV.deparallelize # Or install can fail making the same folder at the same time
    system "make", "install"
  end

  test do
    cp test_fixtures("test.png"), "test.png"
    assert_match "\e[0;5;34;44m", shell_output("#{bin}/img2txt test.png")
  end
end
