class Tasksh < Formula
  desc "Shell wrapper for Taskwarrior commands"
  homepage "https://github.com/GothenburgBitFactory/taskshell"
  url "https://github.com/GothenburgBitFactory/taskshell/releases/download/v1.2.0/tasksh-1.2.0.tar.gz"
  sha256 "6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd"
  license "MIT"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cb996720a985946772c2f2d35a4167e49795bcc7d8cea378eb358557fd5fc1e9"
  end

  revision 1
  head "https://github.com/GothenburgBitFactory/taskshell.git", branch: "master"

  livecheck do
    url "https://gothenburgbitfactory.org"
    regex(/href=.*?tasksh[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "cmake" => :build
  depends_on "readline" # Possible opportunistic linkage. TODO: Check if this can be removed.
  depends_on "task"

  on_linux do
    depends_on "readline"
  end

  deny_network_access!

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"tasksh", "--version"
    (testpath/".taskrc").write "data.location=#{testpath}/.task\n"
    assert_match "Created task 1.", pipe_output(bin/"tasksh", "add Test Task", 0)
  end
end
