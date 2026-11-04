class Getxbook < Formula
  desc "Tools to download ebooks from various sources"
  homepage "https://njw.name/getxbook/"
  url "https://njw.name/getxbook/getxbook-1.3.tar.xz"
  sha256 "a1b8252a50ba61e7c66a82161af35e08f4e6187e8c2cea1e2a040d167932de18"
  license "ISC"

  livecheck do
    url :homepage
    regex(/href=.*?getxbook[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3041f79e5d695b3ca4edcdf999f3f2f92106f075c406f68b640f900d0f53dc9a"
  end

  depends_on "openssl@4"

  deny_network_access!

  def install
    system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
    bin.install "getgbook", "getabook", "getbnbook"
  end

  test do
    assert_match "getgbook #{version}", shell_output("#{bin}/getgbook", 1)
  end
end
