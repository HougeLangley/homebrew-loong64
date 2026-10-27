class Vcs < Formula
  desc "VCS Repo management through a common interface in Go"
  homepage "https://example.org/vcs"
  version "1.13.3"
  url "http://127.0.0.1:8080/brew/bottles/vcs--1.13.3.loongarch64.bottle.tar.gz"
  sha256 "a6f2c3791bf22db213b4949c1c8230e8793099ac9438037e78e9403007cb9023"

  def install
    bin.install "vcs"
  end

  test do
    system "#{bin}/vcs"
  end
end
