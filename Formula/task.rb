class Task < Formula
  desc "A fast, cross-platform build tool inspired by Make, designed for modern workflows."
  homepage "https://example.org/task"
  version "3.54.0"
  url "http://127.0.0.1:8080/brew/bottles/task--3.54.0.loongarch64.bottle.tar.gz"
  sha256 "42368a40246e2275c549dad077461558087cd714ce8ffd4d5da39cbf687d828b"

  def install
    bin.install "task"
  end

  test do
    system "#{bin}/task"
  end
end
