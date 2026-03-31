class Delta < Formula
  desc "Syntax-highlighting pager for git and diff output"
  homepage "https://github.com/dandavison/delta"
  url "https://github.com/dandavison/delta/archive/refs/tags/0.19.2.tar.gz"
  sha256 "e32244c8cb42caf9abaa7188f7f3b4d563094712556e9d5537201e0d6b5a635f"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"delta", "--version"
  end
end
