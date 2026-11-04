class OvhTtyrec < Formula
  desc "Enhanced (but compatible) version of the classic ttyrec"
  homepage "https://github.com/ovh/ovh-ttyrec"
  url "https://github.com/ovh/ovh-ttyrec/archive/refs/tags/v1.2.0.0.tar.gz"
  sha256 "74a474ea33090a9a814c186429c2f725c0bfa1f9d3ceee03caf999daf047eb41"
  license all_of: ["BSD-3-Clause", "BSD-4-Clause-UC"]


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d5f91e079ed7961e01e02dc6ee2e9148bb6a6da67fe44b1a56a90f4e0361a511"
  end

  depends_on "zstd"

  conflicts_with "ttyrec", because: "both install the same binaries"

  def install
    ENV["NO_STATIC_ZSTD"] = "1"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.tty").binwrite([0, 0, 4].pack("V3") + "test" + [9, 0, 3].pack("V3") + "end")

    assert_equal "9\ttest.tty", shell_output("#{bin}/ttytime test.tty").strip
  end
end
