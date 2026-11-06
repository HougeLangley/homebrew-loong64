class Imageworsener < Formula
  desc "Utility and library for image scaling and processing"
  homepage "https://entropymine.com/imageworsener/"
  url "https://entropymine.com/imageworsener/imageworsener-1.3.5.tar.gz"
  sha256 "a7fbb65c5ade67d9ebc32e52c58988a4f986bacc008c9021fe36b598466d5c8d"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4609a9295d2a0f36a14cbf4db52f69a6a14739c52e596a68546b727d4d8fccff"
  end

  livecheck do
    url :homepage
    regex(/href=.*?imageworsener[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/jsummers/imageworsener.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "jpeg-turbo"
  depends_on "libpng"

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

    if build.head?
      inreplace "./scripts/autogen.sh", "libtoolize", "glibtoolize"
      system "./scripts/autogen.sh"
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--without-webp"
    system "make", "install"
    pkgshare.install "tests"
  end

  test do
    cp_r Dir["#{pkgshare}/tests/*"], testpath
    system "./runtest", bin/"imagew"
  end
end
