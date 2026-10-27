class Gitjacker < Formula
  desc "🔪 :octocat: Leak git repositories from misconfigured websites"
  homepage "https://example.org/gitjacker"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/gitjacker--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "fba10b41f8a5234b1c3f19a0944f237df871ac73ca2dbae45f15fa1f870e773d"

  def install
    bin.install "gitjacker"
  end

  test do
    system "#{bin}/gitjacker"
  end
end
