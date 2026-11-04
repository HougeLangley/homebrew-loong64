class Musepack < Formula
  desc "Audio compression format and tools"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/musepack_src_r475.tar.gz"
  version "r475"
  sha256 "a4b1742f997f83e1056142d556a8c20845ba764b70365ff9ccf2e3f81c427b2b"
  license all_of: [
    "BSD-3-Clause", # mpc2sv8, mpccut, mpcdec, mpcgain, wavcmp
    "LGPL-2.1-or-later", # mpcenc
    "GPL-2.0-or-later", # mpcchap
    "Zlib", # common/huffman-bcl.c
  ]

  livecheck do
    url "https://www.musepack.net/index.php?pg=src"
    regex(/href=.*?musepack(?:[._-]src)?[._-](r\d+)\.t/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fcec6d58514896fe2c54c7b8bd286734a7fa0d5e9da12014d455bd3564d70c22"
  end

  depends_on "cmake" => :build
  depends_on "libcuefile"
  depends_on "libreplaygain"

  resource "test-mpc", :test do
    url "https://trac.ffmpeg.org/raw-attachment/ticket/1160/decodererror.mpc"
    sha256 "b16d876b58810cdb7fc06e5f2f8839775efeffb9b753948a5a0f12691436a15c"
  end

  # Backport upstream fixes from SVN for `-fno-common` and installing shared library
  patch :p0 do
    file "Patches/musepack/r479.patch"
  end
  patch :p0 do
    file "Patches/musepack/r482.patch"
  end
  patch :p0 do
    file "Patches/musepack/r491.patch"
  end

  # Apply Gentoo patches for fixing parallel build and another `-fno-common` issue
  patch do
    url "https://raw.githubusercontent.com/gentoo/gentoo/f5d4d4995d45baf77c176224b62e424dca037aef/media-sound/musepack-tools/files/musepack-tools-495-fixup-link-depends.patch"
    sha256 "6dbada5a1e90c8fd1fe60084c04e2193cd027c6959ecaf6a37151a674ddb6a77"
    type :unofficial
  end
  patch do
    url "https://raw.githubusercontent.com/gentoo/gentoo/f5d4d4995d45baf77c176224b62e424dca037aef/media-sound/musepack-tools/files/musepack-tools-495-incompatible-pointers.patch"
    sha256 "25b43fa3ad4ae6eef1e483e3b675b521049901809a024e22aa0aee2237501654"
    type :unofficial
  end

  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource("test-mpc").stage do
      assert_match(/441001 samples decoded in/,
                   shell_output("#{bin}/mpcdec decodererror.mpc 2>&1"))
    end
  end
end
