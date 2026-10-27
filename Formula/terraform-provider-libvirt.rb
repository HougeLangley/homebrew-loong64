class Terraform-provider-libvirt < Formula
  desc "Terraform provisioning with Linux KVM using libvirt"
  homepage "https://example.org/terraform-provider-libvirt"
  version "0.9.9"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-libvirt--0.9.9.loongarch64.bottle.tar.gz"
  sha256 "4287be20b0f4d2eb1cf9fcdac64823566fd11e4bbfd1a4f7649ebce0e6fdd44c"

  def install
    bin.install "terraform-provider-libvirt"
  end

  test do
    system "#{bin}/terraform-provider-libvirt"
  end
end
