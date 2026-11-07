class Snooze < Formula
  desc "Run a command at a particular time"
  homepage "https://github.com/leahneukirchen/snooze"
  url "https://github.com/leahneukirchen/snooze/archive/refs/tags/v0.6.tar.gz"
  sha256 "3a4a2f3f00d42e30647d9af79c8e417990ced6c3f0565474b1ca717938b1e2ab"
  license :public_domain



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ee4dfcbc2d3cc804b4790ccbe6a4c711c3bfc4a9bbbe310b4b153bbb45b3ac23"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "T00:00:00", shell_output("#{bin}/snooze -n")
  end
end
