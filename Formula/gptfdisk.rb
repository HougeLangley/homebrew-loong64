class Gptfdisk < Formula
  desc "Text-mode partitioning tools"
  homepage "https://www.rodsbooks.com/gdisk/"
  url "https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/1.0.10/gptfdisk-1.0.10.tar.gz"
  sha256 "2abed61bc6d2b9ec498973c0440b8b804b7a72d7144069b5a9209b2ad693a282"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "698d27f81461833489fd9a636297db186b52fafe1300063781fe00eca46068c3"
  end

  depends_on "popt"

  uses_from_macos "ncurses"

  on_linux do
    depends_on "util-linux"
  end

  def install
    if OS.mac?
      inreplace "Makefile.mac" do |s|
        s.gsub! "/usr/local/Cellar/ncurses/6.2/lib/libncurses.dylib", "-L/usr/lib -lncurses"
        s.gsub! "-L/usr/local/lib $(LDLIBS) -lpopt", "-L#{formula_opt_lib("popt")} $(LDLIBS) -lpopt"
      end

      system "make", "-f", "Makefile.mac"
    else
      %w[ncurses popt util-linux].each do |dep|
        ENV.append_to_cflags "-I#{formula_opt_include(dep)}"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib(dep)}"
      end

      system "make", "-f", "Makefile"
    end

    %w[cgdisk fixparts gdisk sgdisk].each do |program|
      bin.install program
      man8.install "#{program}.8"
    end
  end

  test do
    system "dd", "if=/dev/zero", "of=test.dmg", "bs=1024k", "count=1"
    assert_match "completed successfully", shell_output("#{bin}/sgdisk -o test.dmg")
    assert_match "GUID", shell_output("#{bin}/sgdisk -p test.dmg")
    assert_match "Found valid GPT with protective MBR", shell_output("#{bin}/gdisk -l test.dmg")
  end
end
