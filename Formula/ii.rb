class Ii < Formula
  desc "Minimalist IRC client"
  homepage "https://tools.suckless.org/ii/"
  url "https://dl.suckless.org/tools/ii-2.0.tar.gz"
  sha256 "4f67afcd208c07939b88aadbf21497a702ad0a07f9b5a6ce861f9f39ffe5425b"
  license "MIT"
  head "https://git.suckless.org/ii/", using: :git, branch: "master"

  livecheck do
    url "https://dl.suckless.org/tools/"
    regex(/href=.*?ii[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  allow_network_access! :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2f555a6d860ff54d3f7be3403a8b9ca202f5e628a2fae8370597e9c146f0e82a"
  end

  def install
    # macOS already provides strlcpy
    if OS.mac?
      inreplace "Makefile" do |s|
        s.gsub! "-D_DEFAULT_SOURCE -DNEED_STRLCPY", "-D_DEFAULT_SOURCE"
        s.gsub! "= strlcpy.o", "="
      end
    end

    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    port = free_port
    output = shell_output("#{bin}/ii -s localhost -p #{port} 2>&1", 1)
    assert_match "#{bin}/ii: could not connect to localhost:#{port}:", output.chomp
  end
end
