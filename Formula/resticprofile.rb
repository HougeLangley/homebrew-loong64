class Resticprofile < Formula
  desc "Configuration profiles manager and scheduler for restic backup"
  homepage "https://example.org/resticprofile"
  version "0.33.1"
  url "http://127.0.0.1:8080/brew/bottles/resticprofile--0.33.1.loongarch64.bottle.tar.gz"
  sha256 "8f77e84e805b66e59cdb5bbf6f03b5a10f06c523de9b4c9b44aab12c205366a3"

  def install
    bin.install "resticprofile"
  end

  test do
    system "#{bin}/resticprofile"
  end
end
