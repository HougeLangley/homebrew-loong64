class Um < Formula
  desc "Command-line utility for creating and maintaining personal man pages"
  homepage "https://github.com/sinclairtarget/um"
  url "https://github.com/sinclairtarget/um/archive/refs/tags/4.2.0.tar.gz"
  sha256 "f8c3f4bc5933cb4ab9643dcef7b01b8e8edf2dcbcd8062ef3ef214d1673ae64e"
  license "MIT"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "905c2929f20c1022a6f298ab7c4283a494fcfd190dab195b7d2666823e3ab797"
  end



  depends_on "ruby"

  resource "kramdown" do
    url "https://rubygems.org/gems/kramdown-1.17.0.gem"
    sha256 "5862410a2c1692fde2fcc86d78d2265777c22bd101f11c76442f1698ab242cd8"
  end

  def install
    ENV["GEM_HOME"] = libexec

    resources.each do |r|
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "um.gemspec"
    system "gem", "install", "--ignore-dependencies", "um-#{version}.gem"

    bin.install libexec/"bin/um"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])

    bash_completion.install "um-completion.sh" => "um"
    man1.install Dir["doc/man1/*"]
  end

  test do
    system bin/"um", "topic", "-d" # Set default topic

    output = shell_output("#{bin}/um topic")
    assert_match shell_output("#{bin}/um config default_topic"), output
  end
end
