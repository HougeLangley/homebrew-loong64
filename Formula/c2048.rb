class C2048 < Formula
  desc "Console version of 2048"
  homepage "https://github.com/mevdschee/2048.c"
  url "https://github.com/mevdschee/2048.c/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "83b9008dc77d7ab2ad721d7316551fb015dce97c40337a354040fe45d8296fd4"
  license "MIT"
  head "https://github.com/mevdschee/2048.c.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bc759fc71c2e271ef6c051b63ce02b0bfba064e0eabdc539a7303eb02dceb654"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = shell_output("#{bin}/2048 test")
    assert_match "All 13 tests executed successfully", output
  end
end
