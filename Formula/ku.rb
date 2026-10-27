class Ku < Formula
  desc "A fast, keyboard-driven Kubernetes TUI. Browse any resource, edit objects, follow logs, an"
  homepage "https://example.org/ku"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/ku--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "6934044e16b1d50cc95042e8ddce71768ec6f908855da2877cd279fca2b35914"

  def install
    bin.install "ku"
  end

  test do
    system "#{bin}/ku"
  end
end
