class Lockrun < Formula
  desc "Run cron jobs with overrun protection"
  homepage "http://unixwiz.net/tools/lockrun.html"
  url "http://unixwiz.net/tools/lockrun.c"
  version "1.1.3"
  sha256 "cea2e1e64c57cb3bb9728242c2d30afeb528563e4d75b650e8acae319a2ec547"
  license :public_domain


  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fdbe667b9b97a960f82cbb305042540d9aaff5c939a6a4eaf11bea5cee5298b7"
  end

  def install
    system ENV.cc, "lockrun.c", "-o", "lockrun"
    bin.install "lockrun"
  end

  test do
    system bin/"lockrun", "--version"
  end
end
