class Latino < Formula
  desc "Open source programming language for Latinos and Hispanic speakers"
  homepage "https://www.lenguajelatino.org/"
  url "https://github.com/lenguaje-latino/latino.git",
      tag:      "v1.4.4",
      revision: "4d8ed2e690dd1efcc47a9f8f790b8a9aeba4b808"
  license "MIT"
  head "https://github.com/lenguaje-latino/latino.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1c3309bf0c6d316dc293b6cec10cebeb605b153a2013f0a94b5bc86f62becf20"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "readline"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test1.lat").write "poner('hola mundo')"
    (testpath/"test2.lat").write <<~EOS
      desde (i = 0; i <= 10; i++)
        escribir(i)
      fin
    EOS
    output = shell_output("#{bin}/latino test1.lat")
    assert_equal "hola mundo", output.chomp
    output2 = shell_output("#{bin}/latino test2.lat")
    assert_equal "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10", output2.chomp
  end
end
