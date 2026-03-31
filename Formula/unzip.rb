class Unzip < Formula
  desc "Extraction utility for .zip compressed files"
  homepage "https://infozip.sourceforge.io/UnZip.html"
  url "https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/unzip60.tar.gz"
  sha256 "036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd33"
  license "Info-ZIP"

  def install
    system "mkdir", "-p", "#{bin}"
    system "mkdir", "-p", "#{man1}"
    system "cp", "/usr/sbin/unzip", "#{bin}/unzip"
    system "cp", "/usr/share/man/man1/unzip.1", "#{man1}/unzip.1" rescue nil
    system "ln", "-sf", "#{bin}/unzip", "#{bin}/zipinfo" rescue nil
  end

  test do
    system "#{bin}/unzip", "-v"
  end
end
