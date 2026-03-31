class Nginx < Formula
  desc "HTTP(S) server and reverse proxy, and IMAP/POP3 proxy server"
  homepage "https://nginx.org/"
  url "https://nginx.org/download/nginx-1.27.4.tar.gz"
  sha256 "294816f66468d04e0a3f576a43e4d1c119d79da91e3cab215c0b4c2e9a57d9d5"
  license "BSD-2-Clause"
  head "https://hg.nginx.org/nginx/", using: :hg

  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "zlib-ng-compat"

  def install
    # keep clean copy of source for compiling dynamic modules e.g. passenger
    (pkgshare/"src").mkpath

    args = [
      "--prefix=#{prefix}",
      "--sbin-path=#{bin}/nginx",
      "--with-cc-opt=#{ENV.cflags}",
      "--with-ld-opt=#{ENV.ldflags}",
      "--conf-path=#{etc}/nginx/nginx.conf",
      "--pid-path=#{var}/run/nginx.pid",
      "--lock-path=#{var}/run/nginx.lock",
      "--http-client-body-temp-path=#{var}/run/nginx/client_body_temp",
      "--http-proxy-temp-path=#{var}/run/nginx/proxy_temp",
      "--http-fastcgi-temp-path=#{var}/run/nginx/fastcgi_temp",
      "--http-uwsgi-temp-path=#{var}/run/nginx/uwsgi_temp",
      "--http-scgi-temp-path=#{var}/run/nginx/scgi_temp",
      "--with-http_ssl_module",
      "--with-http_v2_module",
      "--with-http_realip_module",
      "--with-http_gzip_static_module",
      "--with-http_stub_status_module",
      "--with-pcre",
      "--with-pcre-jit",
    ]

    args << "--with-openssl=#{Formula["openssl@3"].opt_prefix}"

    system "./configure", *args
    system "make", "install"

    (pkgshare/"src").install Dir["*"]

    rm bin/"nginx"
    bin.install_symlink sbin/"nginx"

    (var/"run/nginx").mkpath
    (var/"log/nginx").mkpath
  end

  def caveats
    <<~EOS
      Docroot is: #{var}/www
      The default port has been set in #{etc}/nginx/nginx.conf to 8080
      nginx will load all files in #{etc}/nginx/servers/.
    EOS
  end

  service do
    run [opt_bin/"nginx", "-g", "daemon off;"]
    keep_alive true
    error_log_path var/"log/nginx/error.log"
    log_path var/"log/nginx/access.log"
    working_dir var
  end

  test do
    system bin/"nginx", "-t", "-c", etc/"nginx/nginx.conf"
    system bin/"nginx", "-V"
  end
end
