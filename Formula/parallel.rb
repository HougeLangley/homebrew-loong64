class Parallel < Formula
  desc "Shell command parallelization utility"
  homepage "https://www.gnu.org/software/parallel/"
  url "https://ftp.gnu.org/gnu/parallel/parallel-20250122.tar.bz2"
  sha256 "36f274c866e2c7d5d3c108e5c3a5c754c8d6b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
    bash_completion.install share/"bash-completion/completions/parallel"
  end

  test do
    system bin/"parallel", "--version"
  end
end
