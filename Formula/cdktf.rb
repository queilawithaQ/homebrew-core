require "language/node"

class Cdktf < Formula
  desc "Cloud Development Kit for Terraform"
  homepage "https://github.com/hashicorp/terraform-cdk"
  url "https://registry.npmjs.org/cdktf-cli/-/cdktf-cli-0.4.0.tgz"
  sha256 "b38f9482eb1f6b9693a8c60cebe6d0c2ea8ed87fc325440720f3ca6dbd6cd1de"
  license "MPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "353334daf410e4dec786c28a4dc0777b14824997ebdc7a2de238975d4682c362"
    sha256 cellar: :any_skip_relocation, big_sur:       "80d45917fee0a957cc5917262e54f5dd70e3bbcef6844da7b45394b079f30adb"
    sha256 cellar: :any_skip_relocation, catalina:      "80d45917fee0a957cc5917262e54f5dd70e3bbcef6844da7b45394b079f30adb"
    sha256 cellar: :any_skip_relocation, mojave:        "80d45917fee0a957cc5917262e54f5dd70e3bbcef6844da7b45394b079f30adb"
  end

  depends_on "node"
  depends_on "terraform"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "ERROR: Cannot initialize a project in a non-empty directory",
      shell_output("#{bin}/cdktf init --template='python' 2>&1", 1)
  end
end
