class Modman < Formula
  desc "Module deployment script geared towards Magento development"
  homepage "https://github.com/colinmollenhour/modman"
  url "https://github.com/colinmollenhour/modman/archive/refs/tags/1.14.tar.gz"
  sha256 "58ac5b27b11def9ba162881c3687f2085c06a6ed4cfb496bafdc64ce1a2eaac6"
  license "Apache-2.0"


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "43f5c85176be4d65b206502adc19fc8d562f5f6e208d853728a68ff073f55070"
  end

  def install
    bin.install "modman"
    bash_completion.install "bash_completion" => "modman"
  end

  test do
    system bin/"modman"
  end
end
