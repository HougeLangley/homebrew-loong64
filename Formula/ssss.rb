class Ssss < Formula
  desc "Shamir's secret sharing scheme implementation"
  homepage "http://point-at-infinity.org/ssss/"
  # Upstream is only available via HTTP, so we prefer Debian's HTTPS mirror
  url "https://deb.debian.org/debian/pool/main/s/ssss/ssss_0.5.orig.tar.gz"
  mirror "http://point-at-infinity.org/ssss/ssss-0.5.tar.gz"
  sha256 "5d165555105606b8b08383e697fc48cf849f51d775f1d9a74817f5709db0f995"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?ssss[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c58661855669369ab47815c94935d42c24ee2af1e34ed5fce4d6074b14b6d4ac"
  end

  depends_on "gmp"
  depends_on "xmltoman"

  deny_network_access!

  def install
    inreplace "Makefile" do |s|
      # Compile with -DNOMLOCK to avoid warning on every run on macOS.
      s.gsub! "-W ", "-W -DNOMLOCK $(CFLAGS) $(LDFLAGS)"
    end

    # Temporary Homebrew-specific work around for linker flag ordering problem in Ubuntu 16.04.
    # Remove after migration to 18.04.
    inreplace "Makefile", "-lgmp -o ssss-split ssss.c", "ssss.c -lgmp -o ssss-split"

    system "make"
    man1.install "ssss.1"
    bin.install %w[ssss-combine ssss-split]
  end

  test do
    shares = pipe_output("#{bin}/ssss-split -t 3 -n 5 -w brew -Q", "Homebrew secret\n", 0).lines
    assert_equal 5, shares.count
    shares.each_with_index { |share, i| assert_match(/\Abrew-#{i + 1}-\h+\n\z/, share) }

    secret = pipe_output("#{bin}/ssss-combine -t 3 -Q 2>&1", shares.values_at(0, 2, 4).join, 0)
    assert_equal "Homebrew secret", secret.strip
    secret = pipe_output("#{bin}/ssss-combine -t 3 -Q 2>&1", shares.values_at(1, 3, 4).join, 0)
    assert_equal "Homebrew secret", secret.strip

    output = pipe_output("#{bin}/ssss-combine -t 3 -Q 2>&1", shares.first(2).join, 1)
    assert_match "I/O error while reading shares", output
  end
end
