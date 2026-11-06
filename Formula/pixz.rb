class Pixz < Formula
  desc "Parallel, indexed, xz compressor"
  homepage "https://github.com/vasi/pixz"
  url "https://github.com/vasi/pixz/releases/download/v1.0.7/pixz-1.0.7.tar.gz"
  sha256 "d1b6de1c0399e54cbd18321b8091bbffef6d209ec136d4466f398689f62c3b5f"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f2e7cca54ab7cde0e1cd575e2de91b661da1ad0367b2018e96193873ca9a170d"
  end

  head "https://github.com/vasi/pixz.git", branch: "master"


  depends_on "asciidoc" => :build
  depends_on "docbook-xsl" => :build
  depends_on "pkgconf" => :build
  depends_on "libarchive"
  depends_on "xz"

  uses_from_macos "libxslt"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "a2x", "--doctype", "manpage", "--format", "manpage", "src/pixz.1.asciidoc"
    man1.install "src/pixz.1"
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    testfile = testpath/"file.txt"
    testfile.write "foo"
    system bin/"pixz", testfile, testpath/"file.xz"
  end
end
