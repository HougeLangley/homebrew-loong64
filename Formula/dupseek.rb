class Dupseek < Formula
  desc "Interactive program to find and remove duplicate files"
  homepage "http://www.beautylabs.net/software/dupseek.html"
  url "http://www.beautylabs.net/software/dupseek-1.3.tgz"
  sha256 "c046118160e4757c2f8377af17df2202d6b9f2001416bfaeb9cd29a19f075d93"
  license "GPL-2.0-only"


  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4b23c9b766a6df16e1f7ecba07215ef861d5ae64ff77809ca1d7f09f34b6ef63"
  end

  def install
    bin.install "dupseek"
    doc.install %w[changelog.txt doc.txt copyright credits.txt]
  end

  test do
    mkdir "folder"
    touch "folder/file1"
    assert_empty shell_output("#{bin}/dupseek -b report -f de folder").chomp
    touch "folder/file2"
    assert_match %r{^folder\\/file[12]$}, shell_output("#{bin}/dupseek -b report -f de folder").chomp
    assert_equal "folder\\/file1\nfolder\\/file2", shell_output("#{bin}/dupseek -b report -f e folder | sort").chomp
  end
end
