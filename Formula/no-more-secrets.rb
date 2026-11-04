class NoMoreSecrets < Formula
  desc "Recreates the SETEC ASTRONOMY effect from 'Sneakers'"
  homepage "https://github.com/bartobri/no-more-secrets"
  url "https://github.com/bartobri/no-more-secrets/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "4422e59bb3cf62bca3c73d1fdae771b83aab686cd044f73fe14b1b9c2af1cb1b"
  license "GPL-3.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a2e74696360d69bce1b71cd52856f2ca6cfce649fe0d85490136455c14dc84ba"
  end

  def install
    system "make", "all"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    assert_equal "nms version #{version}", shell_output("#{bin}/nms -v").chomp
  end
end
