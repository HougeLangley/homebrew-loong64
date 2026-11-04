class Blazeblogger < Formula
  desc "CMS for the command-line"
  homepage "http://blaze.blackened.cz/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/blazeblogger/blazeblogger-1.2.0.tar.gz"
  sha256 "39024b70708be6073e8aeb3943eb3b73d441fbb7b8113e145c0cf7540c4921aa"
  license "GPL-3.0-only"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a8591654aa4f019bfac2354a3c22bfeb6852e95d237e9f0da1108e31474cb0c8"
  end

  def install
    # https://code.google.com/p/blazeblogger/issues/detail?id=51
    ENV.deparallelize
    system "make", "install", "prefix=#{prefix}", "compdir=#{prefix}"
  end

  test do
    system bin/"blaze", "init"
    system bin/"blaze", "config", "blog.title", "Homebrew!"
    system bin/"blaze", "make"
    assert_path_exists testpath/"default.css"
    assert_match "Homebrew!", File.read(".blaze/config")
  end
end
