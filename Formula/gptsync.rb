class Gptsync < Formula
  desc "GPT and MBR partition tables synchronization tool"
  homepage "https://refit.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/refit/rEFIt/0.14/refit-src-0.14.tar.gz"
  sha256 "c4b0803683c9f8a1de0b9f65d2b5a25a69100dcc608d58dca1611a8134cde081"
  license "BSD-3-Clause"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1abd97de2e1e656f856f20ef7accaff0b2a1a809cc23afb5e183927954b30120"
  end

  def install
    cd "gptsync" do
      system "make", "-f", "Makefile.unix", "CC=#{ENV.cc}"
      sbin.install "gptsync", "showpart"
      man8.install "gptsync.8"
    end
  end

  test do
    assert_match "No such file or directory", shell_output("#{sbin}/gptsync /dev/this-is-not-real 2>&1", 1)
  end
end
