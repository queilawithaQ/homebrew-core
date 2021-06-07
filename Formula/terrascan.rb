class Terrascan < Formula
  desc "Detect compliance and security violations across Infrastructure as Code"
  homepage "https://www.accurics.com/products/terrascan/"
  url "https://github.com/accurics/terrascan/archive/v1.6.0.tar.gz"
  sha256 "4ff014832f5d4e85ee275930639705a8ad9123eb4691591e6645fc76f1b0eb95"
  license "Apache-2.0"
  head "https://github.com/accurics/terrascan.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8715fbc3d5f142067d6b936305cfa10b46b844921ecb16834bcccb7e9992294b"
    sha256 cellar: :any_skip_relocation, big_sur:       "5add2d64fec4d6deeaa155025546eea4815336e7ab9ff115f71dcd084fcb1251"
    sha256 cellar: :any_skip_relocation, catalina:      "867486bf811cd044f2f54fbebf7d467f694ee9e6a8503c9c578f69fee7a62cb9"
    sha256 cellar: :any_skip_relocation, mojave:        "28b3a265fdd191db24dd14b0da43f6c115ec378c04fdfff71b15f6d9f40f95fd"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/terrascan"
  end

  test do
    (testpath/"ami.tf").write <<~EOS
      resource "aws_ami" "example" {
        name                = "terraform-example"
        virtualization_type = "hvm"
        root_device_name    = "/dev/xvda"

        ebs_block_device {
          device_name = "/dev/xvda"
          snapshot_id = "snap-xxxxxxxx"
          volume_size = 8
        }
      }
    EOS

    expected = <<~EOS
      \tPolicies Validated  :\t203
      \tViolated Policies   :\t0
      \tLow                 :\t0
      \tMedium              :\t0
      \tHigh                :\t0
    EOS

    assert_match expected, shell_output("#{bin}/terrascan scan -f #{testpath}/ami.tf -t aws")

    assert_match "version: v#{version}", shell_output("#{bin}/terrascan version")
  end
end
