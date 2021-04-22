class Luv < Formula
  desc "Bare libuv bindings for lua"
  homepage "https://github.com/luvit/luv"
  version "1.36.0-0"
  license "Apache-2.0"
  revision 1

  stable do
    url "https://github.com/luvit/luv/archive/1.36.0-0.tar.gz"
    sha256 "739d733d32741a9e6caa3ff3a4416dcf121f39f622ee143c7d63130ce7de27be"

    resource "lua-compat-5.3" do
      url "https://github.com/keplerproject/lua-compat-5.3/archive/v0.10.tar.gz"
      sha256 "d1ed32f091856f6fffab06232da79c48b437afd4cd89e5c1fc85d7905b011430"
    end

    # Patch to fix shared library build failure on macOS. Remove at next release.
    # https://github.com/luvit/luv/pull/533
    patch do
      url "https://github.com/luvit/luv/commit/10a27c2b58cb6c2338223b70382397be508cdc86.patch?full_index=1"
      sha256 "793ada6b314f5c6bc308a0ff7d1713632c75d641578455a6570e7bf4a4187e4d"
    end
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "32cdac0b774c5969f7a03904d7aee5ebdb7616d3080cc7f00eff5ce94b39a14e"
    sha256 cellar: :any, big_sur:       "f6c8425adb2baa82ffa7072abd147d953de598d52217c5a809e258497f593b91"
    sha256 cellar: :any, catalina:      "cc68d5c231750bfc1f559f5d6dbc2f36cd6b91d8a5b42119df0c94e3a6ae850a"
    sha256 cellar: :any, mojave:        "7167d544480f6f23dee98b446549fef19c7a2ab188b637804626fdfa83a7f530"
  end

  head do
    url "https://github.com/luvit/luv.git"

    resource "lua-compat-5.3" do
      url "https://github.com/keplerproject/lua-compat-5.3.git"
    end
  end

  depends_on "cmake" => :build
  depends_on "luajit-openresty" => [:build, :test]
  depends_on "libuv"

  def install
    resource("lua-compat-5.3").stage buildpath/"deps/lua-compat-5.3"

    args = std_cmake_args + %W[
      -DWITH_SHARED_LIBUV=ON
      -DWITH_LUA_ENGINE=LuaJIT
      -DLUA_BUILD_TYPE=System
      -DLUA_COMPAT53_DIR=#{buildpath}/deps/lua-compat-5.3
      -DBUILD_MODULE=ON
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_STATIC_LIBS=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    ENV["LUA_CPATH"] = opt_lib/"lua/5.1/?.so"
    ENV.prepend_path "PATH", Formula["luajit-openresty"].opt_bin
    (testpath/"test.lua").write <<~EOS
      local uv = require('luv')
      local timer = uv.new_timer()
      timer:start(1000, 0, function()
        print("Awake!")
        timer:close()
      end)
      print("Sleeping");
      uv.run()
    EOS
    assert_equal "Sleeping\nAwake!\n", shell_output("luajit test.lua")
  end
end
