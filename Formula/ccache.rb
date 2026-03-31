class Ccache < Formula
  desc "Object-file caching compiler wrapper"
  homepage "https://ccache.dev"
  url "https://github.com/ccache/ccache/releases/download/v4.11.2/ccache-4.11.2.tar.gz"
  sha256 "10d8e1540d334c2755ec2cf7ddd18c6343c7cb1f0da097d593f1b95c58571743"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "zstd"

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    
    libexec.mkpath
    %w[clang clang++ cc gcc gcc2 g++ c++].each do |prog|
      libexec.install_symlink bin/"ccache" => prog
    end
  end

  def caveats
    <<~EOS
      To install symlinks for compilers that will automatically use
      ccache, prepend this directory to your PATH:
        #{opt_libexec}
    EOS
  end

  test do
    system "#{bin}/ccache", "--version"
  end
end
