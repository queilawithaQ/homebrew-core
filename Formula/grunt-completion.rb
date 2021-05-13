class GruntCompletion < Formula
  desc "Bash and Zsh completion for Grunt"
  homepage "https://gruntjs.com/"
  url "https://github.com/gruntjs/grunt-cli/archive/v1.4.2.tar.gz"
  sha256 "ee02d056f5bc1c5628c2ac6c1c34546b9d9ee86b8360ec62ec360bf05d97d693"
  license "MIT"
  head "https://github.com/gruntjs/grunt-cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "1b513fa077792ccc90de98bfdf8f4ce6f13f10930979e84694dde159d37781fb"
  end

  def install
    bash_completion.install "completion/bash" => "grunt"
    zsh_completion.install "completion/zsh" => "_grunt"
  end

  test do
    assert_match "-F _grunt_completions",
      shell_output("source #{bash_completion}/grunt && complete -p grunt")
  end
end
