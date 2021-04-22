class MysqlConnectorCxx < Formula
  desc "MySQL database connector for C++ applications"
  homepage "https://dev.mysql.com/downloads/connector/cpp/"
  url "https://dev.mysql.com/get/Downloads/Connector-C++/mysql-connector-c++-8.0.23-src.tar.gz"
  sha256 "9af06495a6a080fed62da70978f1cb0c66f058edd5ea9eda9345a64bf8ec688f"

  livecheck do
    url "https://dev.mysql.com/downloads/connector/cpp/?tpl=files&os=src"
    regex(/href=.*?mysql-connector-c%2B%2B[._-]v?(\d+(?:\.\d+)+)[._-]src\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "9526dc9dfbcb3e82de1a20cac8f1f1c33637b979c34c1fb7e9f825a8a11b41e7"
    sha256 cellar: :any, big_sur:       "7814f13c4b6bd77627e4eea7a82aebe2b97ebe83744dbdf5541509848f89a727"
    sha256 cellar: :any, catalina:      "2e6246b9c2c7adf2c700d88ed5e0d07406c78c5479a064aa87f59a85f9bd8b3d"
    sha256 cellar: :any, mojave:        "083e6ef2e4af3c9d45b0e2b2b2fa89beb63add05e1ef8d30ebc6a39d24fdd9e0"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "mysql-client"
  depends_on "openssl@1.1"

  def install
    system "cmake", ".", *std_cmake_args,
                    "-DINSTALL_LIB_DIR=lib"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <iostream>
      #include <mysqlx/xdevapi.h>
      int main(void)
      try {
        ::mysqlx::Session sess("mysqlx://root@127.0.0.1");
        return 1;
      }
      catch (const mysqlx::Error &err)
      {
        ::std::cout <<"ERROR: " << err << ::std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-I#{include}",
                    "-L#{lib}", "-lmysqlcppconn8", "-o", "test"
    output = shell_output("./test")
    assert_match "Connection refused", output
  end
end
