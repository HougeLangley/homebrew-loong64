class X265 < Formula
  desc "H.265/HEVC encoder"
  homepage "https://github.com/Multicorewareinc/x265"
  url "https://github.com/Multicorewareinc/x265/releases/download/4.3/x265_4.3.tar.gz"
  sha256 "83c53e4c8bbb8f1e33ed59e10a7d621d1d7801ca853910c3eb41f038b8ffb121"
  license "GPL-2.0-or-later"
  compatibility_version 2
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ee3b139eec5b4b8e95ac060059a66a45f56367e3b67dbafff0153be607482792"
  end

  head "https://github.com/Multicorewareinc/x265.git", branch: "master"


  # Backport the upstream LoongArch multi-bit-depth fix. The 10/12-bit
  # libraries use C primitives; the 8-bit build retains LSX/LASX assembly.
  patch do
    url "https://github.com/Multicorewareinc/x265/commit/af35fda1b45bd575b713aef979eed9352e7be1ec.patch"
    sha256 "802b0404a3e298be40368e5504c5ea4ccc321114935302b874988dc7fa011bd0"
  end

  patch do
    url "https://github.com/Multicorewareinc/x265/commit/98eec4057fc20850b59ed292b3f13ddeefc2f93f.patch"
    sha256 "466fc516462b5ca8544b2ea7571d04e2019de085866a6d153bb06f2d324936be"
  end

  depends_on "cmake" => :build

  on_intel do
    depends_on "nasm" => :build
  end

  resource "homebrew-test_video", :test do
    url "https://raw.githubusercontent.com/fraunhoferhhi/vvenc/master/test/data/RTn23_80x44p15_f15.yuv"
    sha256 "ecd2ef466dd2975f4facc889e0ca128a6bea6645df61493a96d8e7763b6f3ae9"
  end

  # downloads a test file
  allow_network_access! :test

  def install
    ENV.runtime_cpu_detection
    # Build based off the script at ./build/linux/multilib.sh
    args = %W[
      -DLINKED_10BIT=ON
      -DLINKED_12BIT=ON
      -DEXTRA_LINK_FLAGS=-L.
      -DEXTRA_LIB=x265_main10.a;x265_main12.a
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    args << "-DENABLE_SVE2=OFF" if OS.linux? && Hardware::CPU.arm?
    high_bit_depth_args = %w[
      -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF
      -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
    ]
    high_bit_depth_args << "-DENABLE_SVE2=OFF" if OS.linux? && Hardware::CPU.arm?

    (buildpath/"8bit").mkpath
    system "cmake", "-S", buildpath/"source", "-B", "10bit",
                    "-DENABLE_HDR10_PLUS=ON",
                    *high_bit_depth_args,
                    *std_cmake_args
    system "cmake", "--build", "10bit"
    mv "10bit/libx265.a", buildpath/"8bit/libx265_main10.a"

    system "cmake", "-S", buildpath/"source", "-B", "12bit",
                    "-DMAIN12=ON",
                    *high_bit_depth_args,
                    *std_cmake_args
    system "cmake", "--build", "12bit"
    mv "12bit/libx265.a", buildpath/"8bit/libx265_main12.a"

    system "cmake", "-S", buildpath/"source", "-B", "8bit", *args, *std_cmake_args
    system "cmake", "--build", "8bit"

    cd "8bit" do
      mv "libx265.a", "libx265_main.a"

      if OS.mac?
        system "libtool", "-static", "-o", "libx265.a", "libx265_main.a",
                          "libx265_main10.a", "libx265_main12.a"
      else
        system "ar", "cr", "libx265.a", "libx265_main.a", "libx265_main10.a",
                           "libx265_main12.a"
        system "ranlib", "libx265.a"
      end

      system "make", "install"
    end
  end

  test do
    resource("homebrew-test_video").stage testpath
    yuv_path = testpath/"RTn23_80x44p15_f15.yuv"
    x265_path = testpath/"x265-8bit.265"
    header = "AAAAAUABDAH//w=="
    assert_match "version #{version}", shell_output("#{bin}/x265 -V 2>&1")

    %w[8 10 12].each do |depth|
      output = testpath/"x265-#{depth}bit.265"
      log = shell_output("#{bin}/x265 --input-res 80x44 --fps 15 --frames 15 --ctu 32 " \
                         "--output-depth #{depth} --no-progress --input #{yuv_path} -o #{output} 2>&1")
      assert_match "encoded 15 frames", log
      assert output.size > 10
    end
    assert_equal header.unpack("m"), [x265_path.read(10)]
  end
end
