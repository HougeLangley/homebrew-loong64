class Fastrace < Formula
  desc "Dependency-free traceroute implementation in pure C"
  homepage "https://github.com/davidesantangelo/fastrace"
  url "https://github.com/davidesantangelo/fastrace/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2306b081389a98486167707733ace0e5811bd154eaf0beffd9f144e081c94ad9"
  license "BSD-2-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "db1e1f907211d9c9d0a4093f296a0c7d17e344e9c268fe9592ecd6dbce781dac"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fastrace -V")

    assert_match "Error creating ICMP receive socket", shell_output("#{bin}/fastrace brew.sh 2>&1", 1)
  end
end
