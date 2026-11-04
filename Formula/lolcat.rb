class Lolcat < Formula
  desc "Rainbows and unicorns in your console!"
  homepage "https://github.com/busyloop/lolcat"
  url "https://github.com/busyloop/lolcat.git",
      tag:      "v100.0.1",
      revision: "27441adfb51bc16073d65dbef300c8d3d7e86dc7"
  license "BSD-3-Clause"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8c99e04c1f0dfd1e9a29ec48fac234ff646b00d239128c4f68055fda3fbc4411"
  end

  depends_on "ruby"

  # List with `gem install --explain lolcat -v #{version}`
  resource "manpages" do
    url "https://rubygems.org/gems/manpages-0.6.1.gem"
    sha256 "cdbad16823c8510c15a93d4cdbd46e7b4290aff8b10f3d4b70caa8e62c8de686"
  end

  resource "optimist" do
    url "https://rubygems.org/gems/optimist-3.0.1.gem"
    sha256 "336b753676d6117cad9301fac7e91dab4228f747d4e7179891ad3a163c64e2ed"
  end

  resource "paint" do
    url "https://rubygems.org/gems/paint-2.3.0.gem"
    sha256 "327d623e4038619d5bd99ae5db07973859cd78400c7f0329eea283cef8e83be5"
  end

  def install
    ENV["GEM_HOME"] = libexec

    resources.each do |r|
      system "gem", "install", r.cached_download, "--ignore-dependencies", "--no-document", "--install-dir", libexec
    end
    system "gem", "build", "lolcat.gemspec"
    system "gem", "install", "--ignore-dependencies", "lolcat-#{version}.gem"

    bin.install libexec/"bin/lolcat"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
    man6.install "man/lolcat.6"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      This is
      a test
    EOS

    system bin/"lolcat", "test.txt"
  end
end
