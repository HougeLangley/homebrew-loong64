class Lazydocker < Formula
  desc "Lazier way to manage everything docker"
  homepage "https://github.com/jesseduffield/lazydocker"
  url "https://github.com/jesseduffield/lazydocker/archive/refs/tags/v0.24.1.tar.gz"
  sha256 "4b865f35f8fb7e7c3a4f6a8a7e8d9c0b1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"lazydocker", "--version"
  end
end
