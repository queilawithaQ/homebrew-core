require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-3.35.10.tgz"
  sha256 "3a1d39ff4a2f576fb73a1c45f7dcf86c5be150b05741abe943c2f1f5e8db3756"
  license "MIT"
  head "https://github.com/netlify/cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c4d8f69acf805f33c6106365437d4154ad1d077ab5732f08d984bef219856138"
    sha256 cellar: :any_skip_relocation, big_sur:       "4281f97a5c6c579090cd7bd3d929e418015f17f17f514127801b268451daae00"
    sha256 cellar: :any_skip_relocation, catalina:      "4281f97a5c6c579090cd7bd3d929e418015f17f17f514127801b268451daae00"
    sha256 cellar: :any_skip_relocation, mojave:        "4281f97a5c6c579090cd7bd3d929e418015f17f17f514127801b268451daae00"
  end

  depends_on "node"

  uses_from_macos "expect" => :test

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
