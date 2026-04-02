class Openjdk < Formula
  desc "Development kit for the Java programming language"
  homepage "https://openjdk.java.net/"
  url "https://github.com/openjdk/jdk22u/archive/refs/tags/jdk-22.0.2+9.tar.gz"
  sha256 "c423c2f762fa4f93a1e6dcfce32c423c2c762fa4f93a1e6dcfce32c423c2c76f"
  license "GPL-2.0-only" => { with: "Classpath-exception-2.0" }

  depends_on "autoconf" => :build
  depends_on "pkgconf" => :build
  depends_on "alsa-lib"
  depends_on "cups"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxrandr"
  depends_on "libxrender"
  depends_on "libxt"
  depends_on "libxtst"
  depends_on "zlib-ng-compat"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    ENV["MAKEFLAGS"] = "JOBS=#{ENV.make_jobs}"
    ENV["CFLAGS"] = "-Wno-error"
    
    args = %W[
      --with-boot-jdk-jvmargs=-Xlint:all
      --with-debug-level=release
      --with-jvm-variants=server
      --with-native-debug-symbols=none
      --with-vendor-bug-url=#{tap.issues_url}
      --with-vendor-name=Homebrew
      --with-vendor-url=#{tap.homepage}
      --with-vendor-vm-bug-url=#{tap.issues_url}
      --with-version-build=#{revision}
      --with-version-pre=
      --without-version-opt
      --without-cacerts
      --disable-warnings-as-errors
      --openjdk-target=#{cpu}-unknown-linux-gnu
    ]

    system "bash", "configure", *args
    system "make", "images"
    
    jdk = Dir["build/*/images/jdk"].first
    libexec.install Pathname.new(jdk).children
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system bin/"java", "-version"
  end
end
