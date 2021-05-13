class Pnpm < Formula
  require "language/node"

  desc "📦🚀 Fast, disk space efficient package manager"
  homepage "https://pnpm.js.org"
  url "https://registry.npmjs.org/pnpm/-/pnpm-6.3.0.tgz"
  sha256 "eebd1dfe4466e5e84fb83332c5bf0e970002eedcb1cae8922257a477d67c5636"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c2108f3f2656d01ba23889c1e7d036853a687bd116160175bbdd12bd3519a20e"
    sha256 cellar: :any_skip_relocation, big_sur:       "39c8de0b03965662a97b16aea4a02abcb545c4ccd2d45f0b1b8d439d569d1bfb"
    sha256 cellar: :any_skip_relocation, catalina:      "39c8de0b03965662a97b16aea4a02abcb545c4ccd2d45f0b1b8d439d569d1bfb"
    sha256 cellar: :any_skip_relocation, mojave:        "39c8de0b03965662a97b16aea4a02abcb545c4ccd2d45f0b1b8d439d569d1bfb"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/pnpm", "init", "-y"
    assert_predicate testpath/"package.json", :exist?, "package.json must exist"
  end
end
