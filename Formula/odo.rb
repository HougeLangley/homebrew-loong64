class Odo < Formula
  desc "Atomic odometer for the command-line"
  homepage "https://github.com/atomicobject/odo"
  url "https://github.com/atomicobject/odo/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "52133a6b92510d27dfe80c7e9f333b90af43d12f7ea0cf00718aee8a85824df5"
  license "ISC"


  conflicts_with "odo-dev", because: "odo-dev also ships 'odo' binary"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "afd660ad6a399ae6cf508a2b5a6daa620e30727b9ce41914f4f0fd0d1c7c86fd"
  end

  def install
    system "make"
    man1.mkpath
    bin.mkpath
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"odo", "testlog"
  end
end
