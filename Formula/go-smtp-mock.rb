class Go-smtp-mock < Formula
  desc "SMTP mock server written on Golang. Mimic any 📤 SMTP server behavior for your test environ"
  homepage "https://example.org/go-smtp-mock"
  version "2.5.4"
  url "http://127.0.0.1:8080/brew/bottles/go-smtp-mock--2.5.4.loongarch64.bottle.tar.gz"
  sha256 "8f46e8fe310b1831a2c32d4e8007a3eb003f58499c36753421c8631d0ca8f49b"

  def install
    bin.install "go-smtp-mock"
  end

  test do
    system "#{bin}/go-smtp-mock"
  end
end
