class Nq < Formula
  desc "Unix command-line queue utility"
  homepage "https://github.com/leahneukirchen/nq"
  url "https://github.com/leahneukirchen/nq/archive/refs/tags/v1.0.tar.gz"
  sha256 "d5b79a488a88f4e4d04184efa0bc116929baf9b34617af70d8debfb37f7431f4"
  license "CC0-1.0"
  head "https://github.com/leahneukirchen/nq.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a6196864a159d9b29c285dcb791a95a8fce3e3f229e2822c730a8b5172128906"
  end

  def install
    system "make", "all", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"nq", "touch", "TEST"
    assert_match "exited with status 0", shell_output("#{bin}/nqtail -a 2>&1")
    assert_path_exists testpath/"TEST"
  end
end
