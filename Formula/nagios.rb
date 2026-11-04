class Nagios < Formula
  desc "Network monitoring and management system"
  homepage "https://www.nagios.org/"
  url "https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.5.14/nagios-4.5.14.tar.gz"
  sha256 "dce59f306577789c56d2748471d4c3856ecba8572d6b0811cf79f9de2f9afabb"
  license "GPL-2.0-only"
  head "https://github.com/NagiosEnterprises/nagioscore.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e075f6c2f0cd54693e3980225abbac98da3536cc7d46c28698bfab067cc33e62"
  end

  depends_on "gd"
  depends_on "libpng"
  depends_on "openssl@4"

  uses_from_macos "unzip" => :build

  on_macos do
    depends_on "jpeg-turbo"
  end

  def nagios_sbin = prefix/"cgi-bin"

  def nagios_etc = etc/"nagios"

  def nagios_var = var/"lib/nagios"

  def htdocs = pkgshare/"htdocs"

  def user
    Utils.safe_popen_read("id", "-un").chomp
  end

  def group
    Utils.safe_popen_read("id", "-gn").chomp
  end

  def install
    args = [
      "--sbindir=#{nagios_sbin}",
      "--sysconfdir=#{nagios_etc}",
      "--localstatedir=#{nagios_var}",
      "--datadir=#{htdocs}",
      "--libexecdir=#{HOMEBREW_PREFIX}/sbin", # Plugin dir
      "--with-cgiurl=/nagios/cgi-bin",
      "--with-htmurl=/nagios",
      "--with-nagios-user=#{user}",
      "--with-nagios-group='#{group}'",
      "--with-command-user=#{user}",
      "--with-httpd-conf=#{share}",
      "--with-ssl=#{formula_opt_prefix("openssl@4")}",
      "--disable-libtool",
    ]
    args << "--with-command-group=_www" if OS.mac?

    system "./configure", *std_configure_args, *args
    system "make", "all"
    system "make", "install"

    # Install config
    system "make", "install-config"
    system "make", "install-webconf"
  end

  post_install_steps do
    mkdir_p "lib/nagios/rw", base: :var
    if_path_exists "{{etc}}/nagios/nagios.cfg" do
      inreplace "nagios/nagios.cfg", /^nagios_user=.*/, "nagios_user={{user}}", base: :etc, audit_result: false
    end
  end

  service do
    run [opt_bin/"nagios", etc/"nagios/nagios.cfg"]
    keep_alive true
    require_root true
    log_path File::NULL
    error_log_path File::NULL
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nagios --version")
  end
end
