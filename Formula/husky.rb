class Husky < Formula
  desc "git hooks made easy"
  homepage "https://example.org/husky"
  version "0.2.16"
  url "http://127.0.0.1:8080/brew/bottles/husky--0.2.16.loongarch64.bottle.tar.gz"
  sha256 "0d58c3098c9f452c559f2ab65e21c0fcae7136026c8dd72f8e34dfc9232d640d"

  def install
    bin.install "husky"
  end

  test do
    system "#{bin}/husky"
  end
end
