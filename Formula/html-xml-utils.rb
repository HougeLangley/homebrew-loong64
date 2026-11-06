class HtmlXmlUtils < Formula
  desc "Tools for manipulating HTML and XML files"
  homepage "https://www.w3.org/Tools/HTML-XML-utils/"
  url "https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-8.8.tar.gz"
  sha256 "950027e1780787ca88271570aae890e0ac9b906f764554c2dee263d4cf7b74b8"
  license "W3C"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "12c913f7f694fdb9ac443f86e7b6b9150b1bb7a00313ee7aee13815485793ede"
  end

  livecheck do
    url :homepage
    regex(/href=.*?html-xml-utils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "CFLAGS", "-std=gnu89"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize # install is not thread-safe
    system "make", "install"
  end

  test do
    assert_equal "&#20320;&#22909;", pipe_output("#{bin}/xml2asc", "你好")
  end
end
