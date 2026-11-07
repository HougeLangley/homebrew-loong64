class Classifier < Formula
  desc "Text classification with Bayes, LSI, kNN, Logistic Regression, and TF-IDF"
  homepage "https://rubyclassifier.com"
  url "https://github.com/cardmagic/classifier/archive/refs/tags/v2.7.0.tar.gz"
  sha256 "3e0cf89c758eb4e7cb96a24dd39a422ec55c742d9663ee5fbb7fc63433deb872"
  license "LGPL-2.1-or-later"



  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2f637d6bfee0df529fd36325c6c1b3e0503bc379578a0c492bf61d4604d4c09a"
  end

  depends_on "ruby"

  allow_network_access! :test

  def fetch
    ENV["BUNDLE_PATH"] = ".bundle"

    system "bundle", "cache", "--no-install"
  end

  def install
    ENV["GEM_HOME"] = libexec

    system "bundle", "install", "--local"
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "--ignore-dependencies", "#{name}-#{version}.gem"

    bin.install libexec/"bin/classifier"
    bin.install libexec/"bin/keywords"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/classifier --version")

    # Test with pre-trained remote model (SMS spam detection)
    output = shell_output("#{bin}/classifier -r sms-spam-filter 'You won a free iPhone'")
    assert_match "spam", output.downcase

    output = shell_output("#{bin}/classifier -r sms-spam-filter 'Meeting at 3pm tomorrow'")
    assert_match "ham", output.downcase

    assert_match version.to_s, shell_output("#{bin}/keywords --version")

    # keywords ships no pre-trained model, so fit a vocabulary first
    (testpath/"corpus.txt").write <<~TEXT
      Ruby is an elegant programming language
      Python is a popular programming language
      Machine learning uses neural networks
    TEXT
    system bin/"keywords", "fit", "-m", testpath/"model.json", testpath/"corpus.txt"
    assert_path_exists testpath/"model.json"

    output = shell_output("#{bin}/keywords -m #{testpath}/model.json 'elegant ruby'")
    assert_match "elegant", output
  end
end
