class Todoist-cli-go < Formula
  desc "CLI for Todoist"
  homepage "https://example.org/todoist-cli-go"
  version "0.24.0"
  url "http://127.0.0.1:8080/brew/bottles/todoist-cli-go--0.24.0.loongarch64.bottle.tar.gz"
  sha256 "c41d34e06e5b4b2f0e120ad32175561c11425039f1bf16aa08de8fe85c04837b"

  def install
    bin.install "todoist-cli-go"
  end

  test do
    system "#{bin}/todoist-cli-go"
  end
end
