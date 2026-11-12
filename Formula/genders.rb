class Genders < Formula
  desc "Static cluster configuration database for cluster management"
  homepage "https://github.com/chaos/genders"
  url "https://github.com/chaos/genders/archive/refs/tags/genders-1-32-1.tar.gz"
  version "1.32.1"
  sha256 "0dc186ec8fd01ec10b5e171d8b8ef632a56d17c135baee2570c0a3c0ffd9d64d"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^genders[._-]v?(\d+(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "863d4428ecf71bca0e10012ab749ca6b62205e7aedcef2d94c16dbe967e7cd8c"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build
  uses_from_macos "python" => :build

  on_linux do
    depends_on "python-setuptools" => :build
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    python3 = which("python3")
    ENV["PYTHON"] = python3

    ENV.append "CXXFLAGS", "-std=c++14"

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--with-java-extensions=no", *args, *std_configure_args

    # setuptools may inherit another Homebrew prefix's Python include path.
    python_include = Utils.safe_popen_read(python3, "-c", "import sysconfig; print(sysconfig.get_path('include'))").strip
    inreplace "src/extensions/python/genderssetup.py",
              "include_dirs = ['../../../config', '../../libgenders'],",
              "include_dirs = ['../../../config', '../../libgenders', '#{python_include}'],"

    system "make", "install"
  end

  test do
    (testpath/"cluster").write <<~EOS
      # slc cluster genders file
      slci,slcj,slc[0-15]  eth2=e%n,cluster=slc,all
      slci                 passwdhost
      slci                 management
      slc[1-15]            compute
    EOS
    assert_match "0 parse errors discovered", shell_output("#{bin}/nodeattr -f cluster -k 2>&1")
  end
end
