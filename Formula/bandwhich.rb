class Bandwhich < Formula
  desc "Terminal bandwidth utilization tool"
  homepage "https://github.com/imsnif/bandwhich"
  url "https://github.com/imsnif/bandwhich/archive/refs/tags/v0.23.1.tar.gz"
  sha256 "8ba9bf6469834ad498b9fd17f86759a16793b70446e7e7c5b44c6bc55d6cd858"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"bandwhich", "--version"
  end
end
