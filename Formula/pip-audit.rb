class PipAudit < Formula
  include Language::Python::Virtualenv

  desc "Audits Python environments and dependency trees for known vulnerabilities"
  homepage "https://pypi.org/project/pip-audit/"
  url "https://files.pythonhosted.org/packages/64/39/07bba0cff03c8126ab1ac319f00746ccc24c784ff8b4ae14963d440d4173/pip-audit-1.0.1.tar.gz"
  sha256 "351f7f279ffb20cfad3fe876e84bf524a87aaa2a8830a4cad66f24f30b2a68f6"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b85be2efd69d045325aba3f8f83f43ed0d6b33d917c65bef25944f75299dbed"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9cdb8ce676b9f5416bb548eadf7a8a8a716657c8bd3e47091c1e4b73b109a1b6"
    sha256 cellar: :any_skip_relocation, monterey:       "eee15be336e2e0cd69a708084f737655e33898d96816c08a21bb8f1baf6733f4"
    sha256 cellar: :any_skip_relocation, big_sur:        "5f3659c7362d095b5b2f8bd3e06f2514431c2d7ea0c6489e5322b0bcbed1097a"
    sha256 cellar: :any_skip_relocation, catalina:       "5cceeae6b7d251b5dc621600fd28ca962c1e11d3c0832c861407057397276af7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6655ade53151bcd5572521b5a88f173915a883145fd0c5e435b208765685c35"
  end

  depends_on "python@3.10"
  depends_on "six"

  resource "CacheControl" do
    url "https://files.pythonhosted.org/packages/d0/74/3748ee1144234a525d84c4905002a5f39795d265bcdecca74142a8df5206/CacheControl-0.12.10.tar.gz"
    sha256 "d8aca75b82eec92d84b5d6eb8c8f66ea16f09d2adb09dbca27fe2d5fc8d3732d"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6c/ae/d26450834f0acc9e3d1f74508da6df1551ceab6c2ce0766a593362d6d57f/certifi-2021.10.8.tar.gz"
    sha256 "78884e7c1d4b00ce3cea67b44566851c4343c120abd683433ce934a68ea58872"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/2f/39/5d8ff929409113e9ff402e405a7c7880ab1fa6f118a4ab72443976a01711/charset-normalizer-2.0.8.tar.gz"
    sha256 "735e240d9a8506778cd7a453d97e817e536bb1fc29f4f6961ce297b9c7a917b0"
  end

  resource "cyclonedx-python-lib" do
    url "https://files.pythonhosted.org/packages/13/ea/5720270a0e984e5dd238ec8e75a8acccb042ac97bcb215be9e2cb339dc1f/cyclonedx-python-lib-0.11.1.tar.gz"
    sha256 "cb0f1730ebe23c37820a9a2d4b42fc1d19fb3e8e6e92dfd3489673c76152e43c"
  end

  resource "html5lib" do
    url "https://files.pythonhosted.org/packages/ac/b6/b55c3f49042f1df3dcd422b7f224f939892ee94f22abcf503a9b7339eaf2/html5lib-1.1.tar.gz"
    sha256 "b2e5b40261e20f354d198eae92afc10d750afb487ed5e50f9c4eaf07c184146f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end

  resource "lockfile" do
    url "https://files.pythonhosted.org/packages/17/47/72cb04a58a35ec495f96984dddb48232b551aafb95bde614605b754fe6f7/lockfile-0.12.2.tar.gz"
    sha256 "6aed02de03cba24efabcd600b30540140634fc06cfa603822d508d5361e9f799"
  end

  resource "msgpack" do
    url "https://files.pythonhosted.org/packages/61/3c/2206f39880d38ca7ad8ac1b28d2d5ca81632d163b2d68ef90e46409ca057/msgpack-1.0.3.tar.gz"
    sha256 "51fdc7fb93615286428ee7758cecc2f374d5ff363bdd884c7ea622a7a327a81e"
  end

  resource "packageurl-python" do
    url "https://files.pythonhosted.org/packages/4b/39/e7665859ad2271aabc489f19df2afff3112e93398bf33fc1d062df41721b/packageurl-python-0.9.6.tar.gz"
    sha256 "c01fbaf62ad2eb791e97158d1f30349e830bee2dd3e9503a87f6c3ffae8d1cf0"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "pip-api" do
    url "https://files.pythonhosted.org/packages/59/34/5e2ad3bf3ac650fa6cfeb7b673e8a3592cd3d12516fd4885248837faae55/pip-api-0.0.25.tar.gz"
    sha256 "f41a337d1a7f81c0712da01da353c016f1f75fc7b1b5bf47af5bfca16b2df5a1"
  end

  resource "progress" do
    url "https://files.pythonhosted.org/packages/2a/68/d8412d1e0d70edf9791cbac5426dc859f4649afc22f2abbeb0d947cf70fd/progress-1.6.tar.gz"
    sha256 "c9c86e98b5c03fa1fe11e3b67c1feda4788b8d0fe7336c2ff7d5644ccfba34cd"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/ab/61/1a1613e3dcca483a7aa9d446cb4614e6425eb853b90db131c305bd9674cb/pyparsing-3.0.6.tar.gz"
    sha256 "d9bdec0013ef1eb5a84ab39a3b3868911598afa494f5faa038647101504e2b81"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "requirements-parser" do
    url "https://files.pythonhosted.org/packages/03/80/eb6ba1dd0429089436e90e556db50884ea21da060b10f2e5668c4cac99da/requirements-parser-0.2.0.tar.gz"
    sha256 "5963ee895c2d05ae9f58d3fc641082fb38021618979d6a152b6b1398bd7d4ed4"
  end

  resource "resolvelib" do
    url "https://files.pythonhosted.org/packages/ac/20/9541749d77aebf66dd92e2b803f38a50e3a5c76e7876f45eb2b37e758d82/resolvelib-0.8.1.tar.gz"
    sha256 "c6ea56732e9fb6fca1b2acc2ccc68a0b6b8c566d8f3e78e0443310ede61dbd37"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "types-setuptools" do
    url "https://files.pythonhosted.org/packages/95/e5/519c37afd2c44d9992241312f2cdc61869d16128fe228bcf2a39d6824185/types-setuptools-57.4.4.tar.gz"
    sha256 "a3cbcbf3f02142bb5d3b5c5f5918f453b8752362b96d58aba2a5cfa43ba6d209"
  end

  resource "types-toml" do
    url "https://files.pythonhosted.org/packages/f6/9d/bc293604d81db1500013bde95569ee532c1502da6bb3c703f3ed5ec52494/types-toml-0.10.1.tar.gz"
    sha256 "5c1f8f8d57692397c8f902bf6b4d913a0952235db7db17d2908cc110e70610cb"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/80/be/3ee43b6c5757cabea19e75b8f46eaf05a2f5144107d7db48c7cf3a864f73/urllib3-1.26.7.tar.gz"
    sha256 "4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece"
  end

  resource "webencodings" do
    url "https://files.pythonhosted.org/packages/0b/02/ae6ceac1baeda530866a85075641cec12989bd8d31af6d5ab4a3e8c92f47/webencodings-0.5.1.tar.gz"
    sha256 "b36a1c245f2d304965eb4e0a82848379241dc04b865afcc4aab16748587e1923"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "No known vulnerabilities found", shell_output("#{bin}/pip-audit --progress-spinner=off 2>&1")
  end
end
