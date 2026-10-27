class Havener < Formula
  desc "Swiss army knife for Kubernetes tasks"
  homepage "https://example.org/havener"
  version "2.2.7"
  url "http://127.0.0.1:8080/brew/bottles/havener--2.2.7.loongarch64.bottle.tar.gz"
  sha256 "9340cdf2fbdc5af377ecd5bba097eb5ce242378bfc3cc90e6d8b6d933ff7feea"

  def install
    bin.install "havener"
  end

  test do
    system "#{bin}/havener"
  end
end
