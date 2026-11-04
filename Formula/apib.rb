class Apib < Formula
  desc "HTTP performance-testing tool"
  homepage "https://github.com/apigee/apib"
  url "https://github.com/apigee/apib/archive/refs/tags/APIB_1_2_1.tar.gz"
  sha256 "e47f639aa6ffc14a2e5b03bf95e8b0edc390fa0bb2594a521f779d6e17afc14c"
  license "Apache-2.0"
  head "https://github.com/apigee/apib.git", branch: "master"

  livecheck do
    url :stable
    regex(/^APIB[._-]v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  deprecate! date: "2026-04-30", because: :repo_archived
  disable! date: "2027-04-30", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a718845aa42230e5ddd30043bbfbe6651c48f6c2e6ba3241e379648f4eb47e01"
  end

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "openssl@4"

  def install
    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    # Workaround to build bundled Abseil
    inreplace "build/_deps/absl-src/absl/strings/internal/str_format/extension.h",
              "#include <cstddef>", "\\0\n#include <cstdint>"
    system "cmake", "--build", "build", "--target", "apib", "apibmon"
    bin.install "build/apib/apib", "build/apib/apibmon"
  end

  test do
    system bin/"apib", "-c 1", "-d 1", "https://www.google.com"
  end
end
