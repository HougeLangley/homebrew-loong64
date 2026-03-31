class Fish < Formula
  desc "User-friendly command-line shell for UNIX-like operating systems"
  homepage "https://fishshell.com"
  url "https://github.com/fish-shell/fish-shell/releases/download/4.0.1/fish-4.0.1.tar.xz"
  sha256 "4ee663715674d63dd7e68387eb9904a3a76bb8119991835c0d52b4c0d4729296"
  license "GPL-2.0-only"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "pcre2"

  def install
    system "cargo", "build", "--release"
    
    bin.install "target/release/fish"
    
    (share/"fish").install Dir["share/*"]
    doc.install Dir["doc/*"]
  end

  test do
    system "#{bin}/fish", "--version"
  end
end
