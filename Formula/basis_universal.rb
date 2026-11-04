class BasisUniversal < Formula
  desc "Basis Universal GPU texture codec command-line compression tool"
  homepage "https://github.com/BinomialLLC/basis_universal"
  url "https://github.com/BinomialLLC/basis_universal/archive/refs/tags/v2_50.tar.gz"
  sha256 "216e49e1f4213d4bfa4afaa07527e16bac28533dddd444197d3aa19230ac130c"
  license "Apache-2.0"
  head "https://github.com/BinomialLLC/basis_universal.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "db8137e2d119c1c335b666f38553d5a2528706ff8b2bef3b2923fcc8e485a865"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "bin/basisu"
  end

  test do
    system bin/"basisu", test_fixtures("test.png")
    assert_path_exists testpath/"test.ktx2"
  end
end
