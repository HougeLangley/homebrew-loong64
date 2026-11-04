class Gauche < Formula
  desc "R7RS Scheme implementation, developed to be a handy script interpreter"
  homepage "https://practical-scheme.net/gauche/"
  url "https://github.com/shirok/Gauche/releases/download/release0_9_15/Gauche-0.9.15.tgz"
  sha256 "3643e27bc7c8822cfd6fb2892db185f658e8e364938bc2ccfcedb239e35af783"
  license "BSD-3-Clause"
  revision 1

  livecheck do
    url :stable
    regex(/^\D*?(\d+(?:[._]\d+)+(?:[._-]?p\d+)?)$/i)
    strategy :github_latest do |json, regex|
      json["tag_name"]&.scan(regex)&.map { |match| match[0].tr("_", ".") }
    end
  end


  deprecate! date: "2027-03-31", because: "needs EOL `mbedtls@3`"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fd21b9e75a3f6fe57b0a1490764b6f80c57b371eb4ae812f4b991b5fc80d500f"
  end

  depends_on "ca-certificates"
  depends_on "mbedtls@3" # https://github.com/shirok/Gauche/issues/1181, https://github.com/shirok/Gauche/issues/1206

  uses_from_macos "libxcrypt"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-multibyte=utf-8
      --with-ca-bundle=#{HOMEBREW_PREFIX}/share/ca-certificates/cacert.pem
    ]
    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/gosh -V")
    assert_match "(version \"#{version}\")", output
    assert_match "(gauche.net.tls mbedtls)", output
  end
end
