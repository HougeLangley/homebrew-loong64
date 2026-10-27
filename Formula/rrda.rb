class Rrda < Formula
  desc "REST API allowing to perform DNS queries over HTTP"
  homepage "https://example.org/rrda"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/rrda--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "e8254ceb766c3e4560236d1d96726a7ddecd89645d5f18048f835099d973acc5"

  def install
    bin.install "rrda"
  end

  test do
    system "#{bin}/rrda"
  end
end
