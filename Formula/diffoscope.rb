class Diffoscope < Formula
  include Language::Python::Virtualenv

  desc "In-depth comparison of files, archives, and directories"
  homepage "https://diffoscope.org"
  url "https://files.pythonhosted.org/packages/b0/c7/ae7879af06be4db0b2440e549a03a2fa25112635faf1f91967f387eb8282/diffoscope-193.tar.gz"
  sha256 "d836ddf24ccb4ffabd798ea1b7fcb66b87e55d5e8ff08286620bb7c64e1d829f"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3c88bbca204e9dea4076ec21b539d8ee790bc2fcef874ca56388c48170d18e58"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b63fef37a8d11b059e029331657e16adac5622337869da292eb0c8423ced2c01"
    sha256 cellar: :any_skip_relocation, monterey:       "46ab52b120369cad9689972e53e65ae7c536cb9425cadc91ab1e8d34c282314a"
    sha256 cellar: :any_skip_relocation, big_sur:        "7b3389d2209e0e8a2e9460b072fc90388464b31ad8f787dd48be563aec9ed875"
    sha256 cellar: :any_skip_relocation, catalina:       "e15adc5e0779098f4e26fc9a9a05514a4fb5b2d0aac983bd1eb90dcef7d11f86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fdab27c74c03ff409e923de438be81ee55042d52cac125870dd4b72b8782a5ba"
  end

  depends_on "libarchive"
  depends_on "libmagic"
  depends_on "python@3.10"

  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/6a/b4/3b1d48b61be122c95f4a770b2f42fc2552857616feba4d51f34611bd1352/argcomplete-1.12.3.tar.gz"
    sha256 "2c7dbffd8c045ea534921e63b0be6fe65e88599990d8dc408ac8c542b72a5445"
  end

  resource "libarchive-c" do
    url "https://files.pythonhosted.org/packages/53/d5/bee2190570a2b4c372a022f16ebfc2313ff717a023f277f5d6f9ebf281a2/libarchive-c-3.1.tar.gz"
    sha256 "618a7ecfbfb58ca15e11e3138d4a636498da3b6bc212811af158298530fbb87e"
  end

  resource "progressbar" do
    url "https://files.pythonhosted.org/packages/a3/a6/b8e451f6cff1c99b4747a2f7235aa904d2d49e8e1464e0b798272aa84358/progressbar-2.5.tar.gz"
    sha256 "5d81cb529da2e223b53962afd6c8ca0f05c6670e40309a7219eacc36af9b6c63"
  end

  resource "python-magic" do
    url "https://files.pythonhosted.org/packages/3a/70/76b185393fecf78f81c12f9dc7b1df814df785f6acb545fc92b016e75a7e/python-magic-0.4.24.tar.gz"
    sha256 "de800df9fb50f8ec5974761054a708af6e4246b03b4bdaee993f948947b0ebcf"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install buildpath

    bin.install libexec/"bin/diffoscope"
    libarchive = Formula["libarchive"].opt_lib/shared_library("libarchive")
    bin.env_script_all_files(libexec/"bin", LIBARCHIVE: libarchive)
  end

  test do
    (testpath/"test1").write "test"
    cp testpath/"test1", testpath/"test2"
    system "#{bin}/diffoscope", "--progress", "test1", "test2"
  end
end
