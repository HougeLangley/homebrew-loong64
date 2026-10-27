class App-store-connect-cli < Formula
  desc "Fast, scriptable CLI for the App Store Connect API. Automate TestFlight, builds, submissio"
  homepage "https://example.org/app-store-connect-cli"
  version "5.17.0"
  url "http://127.0.0.1:8080/brew/bottles/app-store-connect-cli--5.17.0.loongarch64.bottle.tar.gz"
  sha256 "f19b30f19449aa37fdd1e1a44ef771bb073c8095d3c2d40a915b79192f7cb96d"

  def install
    bin.install "app-store-connect-cli"
  end

  test do
    system "#{bin}/app-store-connect-cli"
  end
end
