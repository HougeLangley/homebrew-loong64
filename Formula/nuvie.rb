class Nuvie < Formula
  desc "Ultima 6 engine"
  homepage "https://nuvie.sourceforge.net/"
  license "GPL-2.0-or-later"
  revision 1

  stable do
    url "https://downloads.sourceforge.net/project/nuvie/Nuvie/0.5/nuvie-0.5.tgz"
    sha256 "ff026f6d569d006d9fe954f44fdf0c2276dbf129b0fc5c0d4ef8dce01f0fc257"
    depends_on "sdl12-compat"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4b64bbe70b79cc9e17bcb683b1ee2ad760ada481a732206422880b19054f9a9c"
  end

  head do
    url "https://github.com/nuvie/nuvie.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "sdl2-compat"
  end

  # https://github.com/nuvie/nuvie/commit/759cc0c33bb1a555d6935976c467e52007c3aea1
  deprecate! date: "2026-01-23", because: "has moved to the ScummVM project", replacement_formula: "scummvm"
  disable! date: "2026-01-23", because: "has moved to the ScummVM project", replacement_formula: "scummvm"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    # Work around GCC 11 / Clang 17 failure due to higher default C++ standard.
    # We use C++03 standard as C++11 standard needs upstream fix.
    # We append to CXX because CXXFLAGS is also used for C code somehow.
    # Ref: https://github.com/nuvie/nuvie/commit/69fb52d35d5eaffcf3bca56929ab58a99defec3d
    ENV.append "CXX", "-std=c++03" if build.stable? && (OS.linux? || DevelopmentTools.clang_build_version >= 1700)

    inreplace "./nuvie.cpp" do |s|
      s.gsub! 'datadir", "./data"',
              "datadir\", \"#{lib}/data\""
      s.gsub! 'home + "/Library',
              '"/Library'
      s.gsub! 'config_path.append("/Library/Preferences/Nuvie Preferences");',
              "config_path = \"#{var}/nuvie/nuvie.cfg\";"
      s.gsub! "/Library/Application Support/Nuvie Support/",
              "#{var}/nuvie/game/"
      s.gsub! "/Library/Application Support/Nuvie/",
              "#{var}/nuvie/"
    end

    system "./autogen.sh" if build.head?

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--disable-sdltest", *args, *std_configure_args
    system "make"
    bin.install "nuvie"
    pkgshare.install "data"
    (var/"nuvie/game").mkpath
  end

  def caveats
    <<~EOS
      Copy your Ultima 6 game files into the following directory:
        #{var}/nuvie/game/ultima6/
      Save games will be stored in the following directory:
        #{var}/nuvie/savegames/
      Config file will be located at:
        #{var}/nuvie/nuvie.cfg
    EOS
  end

  test do
    pid = spawn bin/"nuvie"
    sleep 3
    assert_path_exists bin/"nuvie"
    assert_predicate bin/"nuvie", :executable?
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
