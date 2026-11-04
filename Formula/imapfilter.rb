class Imapfilter < Formula
  desc "IMAP message processor/filter"
  homepage "https://github.com/lefcha/imapfilter/"
  url "https://github.com/lefcha/imapfilter/archive/refs/tags/v2.8.5.tar.gz"
  sha256 "81930d83c99a07305554b2fd283422aefb4f069e13cff971377f3f844e601424"
  license "MIT"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9f793632c4dc2f4f1f2ffeeef3f661576cff0ebd511c1b4dfa776fc320018150"
  end

  depends_on "lua"
  depends_on "openssl@4"
  depends_on "pcre2"

  # Apply open PR by Ubuntu maintainer to support OpenSSL 4
  patch do
    url "https://github.com/lefcha/imapfilter/commit/d0e1b29ee5ae0e6e91944fd5c04b943fc810e13c.patch?full_index=1"
    sha256 "b4c52d30ad177546cac2393722184038d974a3b59bdbc14a832c5e3be27f578b"
    type :unofficial
    resolves "https://github.com/lefcha/imapfilter/pull/317"
  end

  deny_network_access!

  def install
    # find Homebrew's libpcre and lua
    ENV.append "CPPFLAGS", "-I#{formula_opt_include("lua")}/lua"
    ENV.append "LDFLAGS", "-L#{formula_opt_lib("pcre2")}"
    ENV.append "LDFLAGS", "-L#{formula_opt_lib("lua")}"
    ENV.append "LDFLAGS", "-liconv" if OS.mac?
    system "make", "PREFIX=#{prefix}", "MANDIR=#{man}", "MYCFLAGS=#{ENV.cflags}", "MYLDFLAGS=#{ENV.ldflags}"
    system "make", "PREFIX=#{prefix}", "MANDIR=#{man}", "install"

    prefix.install "samples"
  end

  def caveats
    <<~EOS
      You will need to create a ~/.imapfilter/config.lua file.
      Samples can be found in:
        #{prefix}/samples
    EOS
  end

  test do
    system bin/"imapfilter", "-V"
  end
end
