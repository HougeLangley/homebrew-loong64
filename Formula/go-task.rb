class Go-task < Formula
  desc "Task is a task runner/build tool that aims to be simpler and easier to use"
  homepage "https://example.org/go-task"
  version "3.54.0"
  url "http://127.0.0.1:8080/brew/bottles/go-task--3.54.0.loongarch64.bottle.tar.gz"
  sha256 "30331d0d204772e59ca7e84f89b95b2b01d1974e5b19be6ad4f03391e2cb536c"

  def install
    bin.install "go-task"
  end

  test do
    system "#{bin}/go-task"
  end
end
