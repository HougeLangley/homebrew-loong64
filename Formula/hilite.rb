class Hilite < Formula
  desc "CLI tool that runs a command and highlights STDERR output"
  homepage "https://sourceforge.net/projects/hilite/"
  url "https://downloads.sourceforge.net/project/hilite/hilite/1.5/hilite.c"
  sha256 "e15bdff2605e8d23832d6828a62194ca26dedab691c9d75df2877468c2f6aaeb"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f240c4636349b9a61b96d078c200484df7b30f26a5607c16375319dbb3f4077f"
  end

  def install
    system ENV.cc, "hilite.c", "-o", "hilite", *ENV.cflags.to_s.split
    bin.install "hilite"
  end

  test do
    system bin/"hilite", "bash", "-c", "echo 'stderr in red' >&2"
  end
end
