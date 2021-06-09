class Twarc < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool and Python library for archiving Twitter JSON"
  homepage "https://github.com/DocNow/twarc"
  url "https://files.pythonhosted.org/packages/2c/43/852f4761699ba0467b0f57632d55d4a061dddc06a108257c73fa7976aba2/twarc-2.1.3.tar.gz"
  sha256 "3d11628eeac7299befcdecb7f5a90b45ac533ad97649d310d5643b59af8e8acd"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "82e3d64d3132210df562c1165d8b03ecada591fc1068b03a0defc8b0345b1c82"
    sha256 cellar: :any_skip_relocation, big_sur:       "2dcc08d6a246e620d7db5f59943f84154bd10c3681e337870bac3b3e388803f8"
    sha256 cellar: :any_skip_relocation, catalina:      "2fb26332fa5a6599c635b76aff950a53d4145aa181cee65d6a32861a0b412820"
    sha256 cellar: :any_skip_relocation, mojave:        "d17c42684e3e38f4a54c0c6c69e5084f7e76381c12e07a8ebccf5cfa718c901c"
  end

  depends_on "python@3.9"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
    sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7/click-8.0.1.tar.gz"
    sha256 "8c04c11192119b1ef78ea049e0a6f0463e4c48ef00a30160c704337586f3ad7a"
  end

  resource "click-config-file" do
    url "https://files.pythonhosted.org/packages/13/09/dfee76b0d2600ae8bd65e9cc375b6de62f6ad5600616a78ee6209a9f17f3/click_config_file-0.6.0.tar.gz"
    sha256 "ded6ec1a73c41280727ec9c06031e929cdd8a5946bf0f99c0c3db3a71793d515"
  end

  resource "click-plugins" do
    url "https://files.pythonhosted.org/packages/5f/1d/45434f64ed749540af821fd7e42b8e4d23ac04b1eda7c26613288d6cd8a8/click-plugins-1.1.1.tar.gz"
    sha256 "46ab999744a9d831159c3411bb0c79346d94a444df9a3a3742e9ed63645f264b"
  end

  resource "configobj" do
    url "https://files.pythonhosted.org/packages/64/61/079eb60459c44929e684fa7d9e2fdca403f67d64dd9dbac27296be2e0fab/configobj-5.0.6.tar.gz"
    sha256 "a2f5650770e1c87fb335af19a9b7eb73fc05ccf22144eb68db7d00cd2bcb0902"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/9e/84/001a3f8d9680f3b26d5e7711e13d5ff92e4b511766a72ac6b4a4e5f06796/oauthlib-3.1.1.tar.gz"
    sha256 "8f0215fcc533dd8dd1bee6f4c412d4f0cd7297307d43ac61666389e3bc3198a3"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/6b/47/c14abc08432ab22dc18b9892252efaf005ab44066de871e72a38d6af464b/requests-2.25.1.tar.gz"
    sha256 "27973dd4a904a4f13b263a19c866c13b92a39ed1c964655f025f3f8d3d75b804"
  end

  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/23/eb/68fc8fa86e0f5789832f275c8289257d8dc44dbe93fce7ff819112b9df8f/requests-oauthlib-1.3.0.tar.gz"
    sha256 "b4261601a71fd721a8bd6d7aa1cc1d6a8a93b4a9f5e96626f8e4d91e8beeaa6a"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/94/40/c396b5b212533716949a4d295f91a4c100d51ba95ea9e2d96b6b0517e5a5/urllib3-1.26.5.tar.gz"
    sha256 "a7acd0977125325f516bda9735fa7142b909a8d01e8b2e4c8108d0984e6e0098"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal "usage: twarc [-h] [--log LOG] [--consumer_key CONSUMER_KEY]",
                 shell_output("#{bin}/twarc -h").chomp.split("\n").first
  end
end
