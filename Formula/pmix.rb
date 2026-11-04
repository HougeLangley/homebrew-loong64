class Pmix < Formula
  desc "Process Management Interface for HPC environments"
  homepage "https://openpmix.org/"
  license "BSD-3-Clause-Open-MPI"
  compatibility_version 1

  stable do
    url "https://github.com/openpmix/openpmix/releases/download/v6.1.0/pmix-6.1.0.tar.bz2"
    sha256 "bb9021c8e100a376f5070ecca727f83a29b5f652dfe381793b88daa79a3b98a2"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      file "Patches/libtool/configure-big_sur.diff"
      type :unofficial
    end
  end

  livecheck do
    url :stable
    strategy :github_releases
  end


  head do
    url "https://github.com/openpmix/openpmix.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build

    uses_from_macos "flex" => :build
    uses_from_macos "python" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f14cc83bba07d50076f29d1256a7a5df7f056ba0412d483373e66e4ec7e0c8c6"
  end

  depends_on "hwloc"
  depends_on "libevent"

  uses_from_macos "perl" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # Avoid references to the Homebrew shims directory
    inreplace "src/runtime/pmix_info_support.c", "PMIX_CC_ABSOLUTE", "\"#{ENV.cc}\""

    args = %W[
      --disable-silent-rules
      --enable-ipv6
      --sysconfdir=#{etc}
      --with-hwloc=#{formula_opt_prefix("hwloc")}
      --with-libevent=#{formula_opt_prefix("libevent")}
      --with-sge
    ]

    system "./autogen.pl", "--force" if build.head?
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    # Based on https://github.com/openpmix/openpmix/blob/master/examples/simple.c
    (testpath/"test.c").write <<~'C'
      #include <stdio.h>
      #include <stdlib.h>
      #include <pmix.h>

      static pmix_proc_t myproc;

      int main(void) {
        pmix_status_t rc;

        if (PMIX_SUCCESS != (rc = PMIx_Init(&myproc, NULL, 0))) {
          if (PMIX_ERR_UNREACH != rc) {
            fprintf(stderr, "Client ns %s rank %d: PMIx_Init failed: %s\n", myproc.nspace, myproc.rank,
                    PMIx_Error_string(rc));
            return 1;
          }
        }

        rc = PMIx_Finalize(NULL, 0);
        if (PMIX_SUCCESS != rc) {
          fprintf(stderr, "Finalize failed: %s\n", PMIx_Error_string(rc));
        }

        fflush(stderr);
        return rc;
      }
    C

    system bin/"pmixcc", "test.c", "-o", "test"
    system "./test"

    assert_match version.to_s, shell_output("#{bin}/pmix_info --pretty-print")
  end
end
