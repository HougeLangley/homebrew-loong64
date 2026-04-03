class Sd < Formula
  desc "Intuitive find & replace CLI (sed alternative)"
  homepage "https://github.com/chmln/sd"
  url "https://github.com/chmln/sd/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2adc1dec0d2c63cbffa94204b212926f2735a59753494fca72c3cfe4001d472f"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"sd", "--version"
  end
end
