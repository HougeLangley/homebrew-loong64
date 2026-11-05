class Souffle < Formula
  desc "Logic Defined Static Analysis"
  homepage "https://souffle-lang.github.io"
  url "https://github.com/souffle-lang/souffle/archive/refs/tags/2.5.tar.gz"
  sha256 "5d009ad6c74ccec10207d865c059716afac625759bff7c8070e529bd80385067"
  license "UPL-1.0"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "67739da1b2d75566aed9710f1a13c8a66ee0cdae2ea1eb32ccd6ef00c9239439"
  end



  depends_on "bison" => :build # Bison included in macOS is out of date.
  depends_on "cmake" => :build
  depends_on "mcpp" => :build
  depends_on "pkgconf" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "libffi"
  uses_from_macos "ncurses"
  uses_from_macos "sqlite"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    cmake_args = [
      "-DSOUFFLE_DOMAIN_64BIT=ON",
      "-DSOUFFLE_GIT=OFF",
      "-DSOUFFLE_BASH_COMPLETION=ON",
      "-DBASH_COMPLETION_COMPLETIONSDIR=#{bash_completion}",
      "-DSOUFFLE_VERSION=#{version}",
      "-DPACKAGE_VERSION=#{version}",
    ]
    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    inreplace "#{buildpath}/build/src/souffle-compile.py" do |s|
      s.gsub!(/"compiler": ".*?"/, "\"compiler\": \"/usr/bin/c++\"")
      s.gsub!(%r{-I.*?/src/include }, "")
      s.gsub!(%r{"source_include_dir": ".*?/src/include"}, "\"source_include_dir\": \"#{include}\"")
    end
    system "cmake", "--build", "build", "--target", "install"
    include.install Dir["src/include/*"]
    man1.install Dir["man/*"]
  end

  test do
    (testpath/"example.dl").write <<~EOS
      .decl edge(x:number, y:number)
      .input edge(delimiter=",")

      .decl path(x:number, y:number)
      .output path(delimiter=",")

      path(x, y) :- edge(x, y).
    EOS
    (testpath/"edge.facts").write <<~EOS
      1,2
    EOS
    system bin/"souffle", "-F", testpath/".", "-D", testpath/".", testpath/"example.dl"
    assert_path_exists testpath/"path.csv"
    assert_equal "1,2\n", shell_output("cat #{testpath}/path.csv")
  end
end
