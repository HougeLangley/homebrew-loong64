class B43Fwcutter < Formula
  desc "Extract firmware from Braodcom 43xx driver files"
  homepage "https://wireless.docs.kernel.org/en/latest/en/users/drivers/b43.html"
  url "https://bues.ch/b43/fwcutter/b43-fwcutter-021.tar.xz"
  sha256 "c21e0ccf0d15e668ade31fe4d4c424ef6be006b85f63603b6f965f4c5a6f3121"
  license "BSD-2-Clause"

  livecheck do
    url "https://bues.ch/b43/fwcutter/"
    regex(/href=.*?b43-fwcutter[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "09f0d62ad29ad0be9b84a246d270a33dc9cd55af21307f25592f9905deea9a31"
  end

  def install
    inreplace "Makefile" do |m|
      # Don't try to chown root:root on generated files
      m.gsub! "install -o 0 -g 0", "install"
      m.gsub! "install -d -o 0 -g 0", "install -d"
      # Fix manpage installation directory
      m.gsub! "$(PREFIX)/man", man
      # Prevent `make` from using SDK metadata as the source file
      m.gsub! "obj/%.o:", "obj/%.o: %.c"
    end
    # b43-fwcutter has no ./configure
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"b43-fwcutter", "--version"
  end
end
