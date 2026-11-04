class FormatUdf < Formula
  desc "Bash script to format a block device to UDF"
  homepage "https://github.com/JElchison/format-udf"
  url "https://github.com/JElchison/format-udf/archive/refs/tags/1.8.0.tar.gz"
  sha256 "52854097db9044d729fbd7cff012f4b554df01c15225ee17ec159c71da174c8d"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a7784a9c9af4b53f872921e64ebdcef6ae566235ad669e5e057e46de65a0dd6b"
  end

  def install
    bin.install "format-udf.sh" => "format-udf"
  end

  test do
    system bin/"format-udf", "-h"
  end
end
