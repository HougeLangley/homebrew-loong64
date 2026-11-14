class Irrlicht < Formula
  desc "Realtime 3D engine"
  homepage "https://irrlicht.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/irrlicht/Irrlicht%20SDK/1.8/1.8.5/irrlicht-1.8.5.zip"
  sha256 "effb7beed3985099ce2315a959c639b4973aac8210f61e354475a84105944f3d"
  # Irrlicht is available under alternative license terms. See
  # https://metadata.ftp-master.debian.org/changelogs//main/i/irrlicht/irrlicht_1.8.4+dfsg1-1.1_copyright
  license "Zlib"
  revision 1
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "31ac9bf9ee769bcc086de1fc30bfe38879ee8ba7a876fc769152df6e87a5f21b"
  end

  head "https://svn.code.sf.net/p/irrlicht/code/trunk"

  livecheck do
    url :stable
    regex(%r{url=.*?/irrlicht[._-]v?(\d+(?:\.\d+)+)\.(?:t|zip)}i)
  end



  depends_on "jpeg-turbo"
  depends_on "libpng"

  uses_from_macos "bzip2"

  on_macos do
    depends_on xcode: :build
  end

  on_linux do
    depends_on "libx11"
    depends_on "libxxf86vm"
    depends_on "mesa"
    depends_on "zlib-ng-compat"
  end

  # Use libraries from Homebrew or macOS
  patch do
    file "Patches/irrlicht/use-system-libs.patch"
  end

  # Update Xcode project to use libraries from Homebrew and macOS
  patch do
    file "Patches/irrlicht/xcode.patch"
  end

  def install
    %w[bzip2 jpeglib libpng zlib].each { |l| rm_r(buildpath/"source/Irrlicht"/l) }

    if OS.mac?
      # Work around error with clang 17
      inreplace "source/Irrlicht/MacOSX/CIrrDeviceMacOSX.mm",
                "(NSOpenGLPixelFormatAttribute)nil", "(NSOpenGLPixelFormatAttribute)0"

      inreplace "source/Irrlicht/MacOSX/MacOSX.xcodeproj/project.pbxproj" do |s|
        s.gsub! "@LIBPNG_PREFIX@", formula_opt_prefix("libpng")
        s.gsub! "@JPEG_PREFIX@", formula_opt_prefix("jpeg-turbo")
      end

      extra_args = []

      # Fix "Undefined symbols for architecture arm64: "_png_init_filter_functions_neon"
      # Reported 18 Nov 2020 https://sourceforge.net/p/irrlicht/bugs/452/
      extra_args << "GCC_PREPROCESSOR_DEFINITIONS='PNG_ARM_NEON_OPT=0'" if Hardware::CPU.arm?

      xcodebuild "-project", "source/Irrlicht/MacOSX/MacOSX.xcodeproj",
                 "-configuration", "Release",
                 "-target", "IrrFramework",
                 "SYMROOT=build",
                 *extra_args

      xcodebuild "-project", "source/Irrlicht/MacOSX/MacOSX.xcodeproj",
                 "-configuration", "Release",
                 "-target", "libIrrlicht.a",
                 "SYMROOT=build",
                 *extra_args

      frameworks.install "source/Irrlicht/MacOSX/build/Release/IrrFramework.framework"
      lib.install_symlink frameworks/"IrrFramework.framework/Versions/A/IrrFramework" => "libIrrlicht.dylib"
      lib.install "source/Irrlicht/MacOSX/build/Release/libIrrlicht.a"
      include.install "include" => "irrlicht"
    else
      cd "source/Irrlicht" do
        inreplace "Makefile" do |s|
          s.gsub! "/usr/X11R6/lib$(LIBSELECT)", formula_opt_lib("libx11")
          s.gsub! "/usr/X11R6/include", formula_opt_include("libx11")
        end
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("bzip2")} -lbz2"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("jpeg-turbo")} -ljpeg"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("libpng")} -lpng"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("zlib-ng-compat")} -lz"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("mesa")}"
        ENV.append "LDFLAGS", "-L#{formula_opt_lib("libxxf86vm")}"
        ENV.append "CXXFLAGS", "-I#{formula_opt_include("libxxf86vm")}"
        args = %w[
          NDEBUG=1
          BZIP2OBJ=
          JPEGLIBOBJ=
          LIBPNGOBJ=
          ZLIBOBJ=
        ]
        system "make", "sharedlib", *args
        system "make", "install", "INSTALL_DIR=#{lib}"
        system "make", "clean"
        system "make", "staticlib", *args
      end
      lib.install "lib/Linux/libIrrlicht.a"
    end

    (pkgshare/"examples").install "examples/01.HelloWorld"
  end

  test do
    assert_match Hardware::CPU.arch.to_s, shell_output("lipo -info #{lib}/libIrrlicht.a") if OS.mac?
    cp_r Dir["#{pkgshare}/examples/01.HelloWorld/*"], testpath
    system ENV.cxx, "main.cpp", "-I#{include}/irrlicht", "-L#{lib}", "-lIrrlicht", "-o", "hello"
  end
end
