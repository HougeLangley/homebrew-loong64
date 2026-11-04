class Htpdate < Formula
  desc "Synchronize time with remote web servers"
  homepage "https://www.vervest.org/htp/"
  url "https://github.com/twekkel/htpdate/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "3f5effa9355db140ef8ace6d17800d48815d1afdcef9d1096510451839dd8de4"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fcb9ea61f108da36d56067208c73d340605392cf68aca2fb4e13a69c3ba77711"
  end

  def install
    system "make", "prefix=#{prefix}",
                   "STRIP=/usr/bin/strip",
                   "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "install"
  end

  test do
    system sbin/"htpdate", "-q", "-d", "-u", ENV["USER"], "example.org"
  end
end
