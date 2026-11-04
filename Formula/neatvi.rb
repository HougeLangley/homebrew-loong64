class Neatvi < Formula
  desc "Clone of ex/vi for editing bidirectional utf-8 text"
  homepage "https://repo.or.cz/neatvi.git"
  url "https://repo.or.cz/neatvi.git",
      tag:      "20",
      revision: "99f326adb10b40e53475beecec12e4a4eae92973"
  license "ISC"
  head "https://repo.or.cz/neatvi.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3df54640f46097edf2e1d1f03610f731c31ab3ac9b98d8e5c79ddc7d10947a67"
  end

  def install
    system "make"
    bin.install "vi" => "neatvi"
  end

  test do
    pipe_output(bin/"neatvi", ":q\n")
  end
end
