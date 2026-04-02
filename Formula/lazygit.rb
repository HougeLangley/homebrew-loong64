class Lazygit < Formula
  desc "Simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  url "https://github.com/jesseduffield/lazygit/archive/refs/tags/v0.48.0.tar.gz"
  sha256 "b850424f116f8d29399f50c240faeda4a8d12f5bf38fe25c6c99c9dddb74f8fc"
  license "MIT"
  head "https://github.com/jesseduffield/lazygit.git", branch: "master"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.buildSource=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    system bin/"lazygit", "--version"
  end
end
