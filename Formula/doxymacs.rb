class Doxymacs < Formula
  desc "Elisp package for using doxygen under Emacs"
  homepage "https://doxymacs.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/doxymacs/doxymacs/1.8.0/doxymacs-1.8.0.tar.gz"
  sha256 "a23fd833bc3c21ee5387c62597610941e987f9d4372916f996bf6249cc495afa"
  license "GPL-2.0-or-later"
  revision 1


  head do
    url "https://git.code.sf.net/p/doxymacs/code.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4969840219ed83a641063a2b598c260458976f5cb946b225f8ee0749c8732465"
  end

  depends_on "doxygen"
  depends_on "emacs"

  uses_from_macos "libxml2"

  deny_network_access!

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lxml2"
    ENV.append "LDFLAGS", "-lxml2"
    # https://sourceforge.net/p/doxymacs/support-requests/5/
    ENV.append "CFLAGS", "-std=gnu89"

    # Fix undefined symbol errors for _xmlCheckVersion, etc.
    # This prevents a mismatch between /usr/bin/xml2-config and the SDK headers,
    # which would cause the build system not to pass the LDFLAGS for libxml2.
    ENV.prepend_path "PATH", "#{MacOS.sdk_path}/usr/bin" if OS.mac?

    system "./bootstrap" if build.head?
    system "./configure", "LIBS=-lxml2", "--with-lispdir=#{elisp}", *std_configure_args
    system "make", "LIBS=-lxml2", "install"
  end

  test do
    (testpath/"test.el").write <<~LISP
      (add-to-list 'load-path "#{elisp}")
      (load "doxymacs")
      (print doxymacs-version)
    LISP

    output = shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
    assert_equal "\"#{version}\"", output
  end
end
