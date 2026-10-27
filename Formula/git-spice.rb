class Git-spice < Formula
  desc "Manage stacked Git branches"
  homepage "https://example.org/git-spice"
  version "0.33.0"
  url "http://127.0.0.1:8080/brew/bottles/git-spice--0.33.0.loongarch64.bottle.tar.gz"
  sha256 "227154a1c6ec6d142648fc812cb404c8bb937bf42e0465a739e47aba659fa456"

  def install
    bin.install "git-spice"
  end

  test do
    system "#{bin}/git-spice"
  end
end
