class Dict < Formula
  desc "Dictionary Server Protocol (RFC2229) client"
  homepage "https://dict.org/bin/Dict"
  url "https://downloads.sourceforge.net/project/dict/dictd/dictd-1.13.3/dictd-1.13.3.tar.gz"
  sha256 "192129dfb38fa723f48a9586c79c5198fc4904fec1757176917314dd073f1171"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2b9c168af293d40e4c959a98616f8f25dbdfad4f3978700f01b96ad8fc557ee4"
  end

  depends_on "libtool" => :build
  depends_on "libmaa"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  allow_network_access! :test

  def install
    ENV["ac_cv_search_yywrap"] = "yes"
    ENV["LIBTOOL"] = "glibtool"
    system "./configure", "--mandir=#{man}",
                          "--sysconfdir=#{etc}",
                          *std_configure_args
    system "make"
    system "make", "install"
    (prefix/"etc/dict.conf").write <<~EOS
      server localhost
      server dict.org
    EOS
  end

  test do
    pipe_output("#{bin}/dictfmt -j -u local -s Test test", ":homebrew:The missing package manager\n", 0)
    (testpath/"dictd.conf").write <<~EOS
      database test { data "#{testpath}/test.dict" index "#{testpath}/test.index" }
    EOS

    port = free_port
    pid = spawn sbin/"dictd", "--config", testpath/"dictd.conf", "--port", port.to_s,
                "--listen-to", "127.0.0.1", "-d", "nodetach"
    begin
      sleep 2
      assert_match "The missing package manager", shell_output("#{bin}/dict -h 127.0.0.1 -p #{port} homebrew")
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
