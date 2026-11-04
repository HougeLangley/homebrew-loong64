class Fatal < Formula
  desc "Facebook Template Library"
  homepage "https://www.facebook.com/groups/libfatal/"
  url "https://github.com/facebook/fatal/archive/refs/tags/v2026.09.14.00.tar.gz"
  sha256 "da43cabebbe0a1b279f5eaf3fe7d3460ed7320887ca033d805b84079bc29e3a1"
  license "BSD-3-Clause"
  head "https://github.com/facebook/fatal.git", branch: "main"


  deprecate! date: "2026-09-27", because: :repo_archived
  disable! date: "2027-03-27", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "38f66d715619f81abfa927c48ab478684bc68f06e59f83848d4ede806826a82d"
  end

  def install
    rm "fatal/.clang-tidy"
    include.install "fatal"
    pkgshare.install "demo", "lesson", *buildpath.glob("*.sh")
    inreplace "README.md" do |s|
      s.gsub!("(lesson/)", "(share/fatal/lesson/)")
      s.gsub!("(demo/)", "(share/fatal/demo/)")
    end
  end

  test do
    system ENV.cxx, "-std=c++14", "-I#{include}",
                    include/"fatal/benchmark/test/benchmark_test.cpp",
                    "-o", "benchmark_test"
    system "./benchmark_test"
  end
end
