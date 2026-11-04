class Lavat < Formula
  desc "Lava lamp simulation using metaballs in the terminal"
  homepage "https://github.com/AngelJumbo/lavat"
  url "https://github.com/AngelJumbo/lavat/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "c5364203a75395953560b173fae90c316b753a046acb8f557c9e684eec6d76ba"
  license "MIT"
  head "https://github.com/AngelJumbo/lavat.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "54c338460f62794ade30c86e4fc55fe3138decf69d226b9d1fbb38ece4e5fd65"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    # GUI app
    assert_match "Usage: lavat [OPTIONS]", shell_output("#{bin}/lavat -h")

    require "pty"

    PTY.spawn(bin/"lavat") do |_r, _w, pid|
      sleep 5
    ensure
      Process.kill("TERM", pid)
    end
  end
end
