class Mainline < Formula
  desc "Git-native memory for coding agents. Repo memory before the diff."
  homepage "https://example.org/mainline"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/mainline--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "a9f09dea632dd43cd846be231ab655b43f0a3afcb0f7ca8a06dfc30fc53dc98f"

  def install
    bin.install "mainline"
  end

  test do
    system "#{bin}/mainline"
  end
end
