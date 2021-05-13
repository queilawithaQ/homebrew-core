require "language/node"

class Eslint < Formula
  desc "AST-based pattern checker for JavaScript"
  homepage "https://eslint.org"
  url "https://registry.npmjs.org/eslint/-/eslint-7.26.0.tgz"
  sha256 "7df1293cce22e076980b9aba48d1521a4ff3edab093b60a0547eb586ccebe4f2"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "660bd8effae7380af4af6c2efc1ca7feed8693bfba4f123ba57a2527d9acc01c"
    sha256 cellar: :any_skip_relocation, big_sur:       "68ab2247338676db29802bcb0b08851d98fc55f7ddc454961f1d18051a514924"
    sha256 cellar: :any_skip_relocation, catalina:      "68ab2247338676db29802bcb0b08851d98fc55f7ddc454961f1d18051a514924"
    sha256 cellar: :any_skip_relocation, mojave:        "68ab2247338676db29802bcb0b08851d98fc55f7ddc454961f1d18051a514924"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/".eslintrc.json").write("{}") # minimal config
    (testpath/"syntax-error.js").write("{}}")
    # https://eslint.org/docs/user-guide/command-line-interface#exit-codes
    output = shell_output("#{bin}/eslint syntax-error.js", 1)
    assert_match "Unexpected token }", output
  end
end
