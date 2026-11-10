class Powerlevel10k < Formula
  desc "Theme for zsh"
  homepage "https://github.com/romkatv/powerlevel10k"
  url "https://github.com/romkatv/powerlevel10k/archive/refs/tags/v1.20.0.tar.gz"
  sha256 "d8187d44b697b3a37a8c4896678b4380e717cbf2850179529358348780a2d3d7"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "76d4403b7b2a6c4c5de414350c14b4176344c91a346cafb1e4a65eb4f5df9095"
  end

  head "https://github.com/romkatv/powerlevel10k.git", branch: "master"

  depends_on "cmake" => :build

  resource "libgit2" do
    url "https://github.com/romkatv/libgit2/archive/tag-2ecf33948a4df9ef45a66c68b8ef24a5e60eaac6.tar.gz"
    sha256 "4ce11d71ee576dbbc410b9fa33a9642809cc1fa687b315f7c23eeb825b251e93"
  end


  uses_from_macos "zsh" => :test

  def install
    libgit2 = resource("libgit2")
    deps = buildpath/"gitstatus/deps"
    deps.mkpath
    cp libgit2.cached_download, deps/"libgit2-tag-2ecf33948a4df9ef45a66c68b8ef24a5e60eaac6.tar.gz"
    cd "gitstatus" do
      # Isolate the pinned static archive from Homebrew library/CMake search
      # paths. The upstream static-PIE binary still runs both protocol self-tests.
      system "env", "-i", "PATH=/usr/bin:/bin", "HOME=#{ENV["HOME"]}",
             "TMPDIR=/home/houge/infra/src/tmp", "LC_ALL=C",
             "CC=/usr/bin/gcc", "CXX=/usr/bin/g++",
             "CXXFLAGS=-Wno-error=unused-result", "./build", "-m", "loongarch64"
    end
    system "make", "zwc"
    pkgshare.install Dir["*"]
  end

  def caveats
    <<~EOS
      To activate this theme, add the following at the end of your .zshrc:

        source #{HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme

      You will also need to restart your terminal for this change to take effect.
    EOS
  end

  test do
    output = shell_output("zsh -fic '. #{pkgshare}/powerlevel10k.zsh-theme && (( ${+P9K_SSH} )) && echo SUCCESS'")
    assert_match "SUCCESS", output

    input = testpath/"gitstatus-input"
    input.binwrite "hello\037\036"
    output = shell_output("#{pkgshare}/gitstatus/usrbin/gitstatusd < #{input}")
    assert_equal "hello\0370\036", output
  end
end
