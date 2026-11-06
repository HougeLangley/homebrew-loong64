class Htmlcxx < Formula
  desc "Non-validating CSS1 and HTML parser for C++"
  homepage "https://htmlcxx.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/htmlcxx/v0.87/htmlcxx-0.87.tar.gz"
  sha256 "5d38f938cf4df9a298a5346af27195fffabfef9f460fc2a02233cbcfa8fc75c8"
  license all_of: ["LGPL-2.0-only", "Apache-2.0"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "76ddcbac7e9d8971870f939be8036d7beb3268f4be090991f301db9ce0795f7b"
  end


  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.cxx11

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/htmlcxx -V 2>&1").chomp
  end
end
