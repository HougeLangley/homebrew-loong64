class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "8c028497e33be976c7431fbd7d4f5b2318422ffd99625f7aa5c8dcf664179d51"
  license "MIT"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "149939567b3dfdf1dadfbace09b81c29c9c62367642edf45c29f094b3c3b8ac4"
  end

  depends_on "postgresql@18" => :test
  depends_on "libpq"
  depends_on "ruby"

  # List with `gem install --explain pgslice -v #{version}`
  # https://rubygems.org/gems/pgslice/versions/#{version}/dependencies

  resource "thor" do
    url "https://rubygems.org/gems/thor-1.4.0.gem"
    sha256 "8763e822ccb0f1d7bee88cde131b19a65606657b847cc7b7b4b82e772bcd8a3d"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.6.3.gem"
    sha256 "1388d0563e13d2758c1089e35e973a3249e955c659592d10e5b77c468f628a99"
  end

  resource "cgi" do
    url "https://rubygems.org/gems/cgi-0.5.1.gem"
    sha256 "e93fcafc69b8a934fe1e6146121fa35430efa8b4a4047c4893764067036f18e9"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["PG_CONFIG"] = formula_opt_bin("libpq")/"pg_config"

    resources.each do |r|
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "pgslice.gemspec"
    system "gem", "install", "--ignore-dependencies", "pgslice-#{version}.gem"

    bin.install libexec/"bin/pgslice"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    ENV["LC_ALL"] = "C"

    postgresql = Formula["postgresql@18"]
    pg_ctl = postgresql.opt_bin/"pg_ctl"
    port = free_port

    system pg_ctl, "initdb", "-D", testpath/"test"
    (testpath/"test/postgresql.conf").write <<~CONF, mode: "a+"
      port = #{port}
    CONF
    system pg_ctl, "start", "-D", testpath/"test", "-l", testpath/"log"

    begin
      ENV["PGSLICE_URL"] = "postgres://localhost:#{port}/postgres"
      output = shell_output("#{bin}/pgslice prep users created_at day 2>&1", 1)
      assert_match "Table not found", output
    ensure
      system pg_ctl, "stop", "-D", testpath/"test"
    end
  end
end
