class Execline < Formula
  desc "Interpreter-less scripting language"
  homepage "https://skarnet.org/software/execline/"
  url "https://skarnet.org/software/execline/execline-2.10.0.0.tar.gz"
  sha256 "561be2ce578604644e2263a889bbdf4736e7980401ee88556a7f9017c166dbab"
  license "ISC"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "be7397663a5ace6ee0531bac0d53c2e7eabef1e8ef5301d6f097ce28fb89c2ee"
  end

  head "git://git.skarnet.org/execline", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?execline[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :build
  depends_on "skalibs"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --disable-silent-rules
      --enable-shared
      --enable-pkgconfig
      --with-pkgconfig=#{formula_opt_bin("pkgconf")}/pkg-config
      --with-sysdeps=#{formula_opt_lib("skalibs")}/skalibs/sysdeps
    ]
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.eb").write <<~EOS
      foreground
      {
        sleep 1
      }
      "echo"
      "Homebrew"
    EOS
    assert_match "Homebrew", shell_output("#{bin}/execlineb test.eb")
  end
end
