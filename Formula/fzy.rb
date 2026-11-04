class Fzy < Formula
  desc "Fast, simple fuzzy text selector with an advanced scoring algorithm"
  homepage "https://github.com/jhawthorn/fzy"
  url "https://github.com/jhawthorn/fzy/archive/refs/tags/1.1.tar.gz"
  sha256 "93d300d9c6c7063b2c6bda4e08a9704a029ec33f609718cd95443d1a890aff4e"
  license "MIT"
  head "https://github.com/jhawthorn/fzy.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7547e0c339ba43ce10c5d068a33edf262414042a113f8adf07cf677f7bd5eae4"
  end

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_equal "foo", pipe_output("#{bin}/fzy -e foo", "bar\nfoo\nqux").chomp
  end
end
