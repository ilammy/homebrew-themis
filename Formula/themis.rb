class Themis < Formula
  desc "High-level cryptographic primitives (BoringSSL flavor)"
  homepage "https://www.cossacklabs.com/themis"
  url "https://github.com/cossacklabs/themis/archive/0.10.0.tar.gz"
  sha256 "329a981e7e57a90107b330172b738104f7189cb20eac043d708c23c5db1570fb"

  depends_on "cmake" => [:build]
  depends_on "go"    => [:build]
  conflicts_with "themis-libressl", "themis-openssl",
    :because => "only one flavor of Themis can exist in PATH"

  # BoringSSL is not available on Homebrew and never will be because its
  # distribution and versioning model strongly suggests projects to build
  # whatever version they like and link against that statically because
  # there are no guarantees of API or ABI stability. <okay.jpg>
  resource "BoringSSL" do
    url "https://github.com/google/boringssl.git",
      :using => :git,
      :revision => "cc9d935256539af2d3b7f831abf57c0d685ffd81"
  end

  def install
    @boringssl = "#{Dir.pwd}/boringssl"
    Dir.mkdir "#{@boringssl}/"
    Dir.mkdir "#{@boringssl}/include"
    Dir.mkdir "#{@boringssl}/lib"
    resource("BoringSSL").stage do
      Dir.mkdir "build"
      Dir.chdir "build" do
        system "cmake", "-DCMAKE_BUILD_TYPE=RelWithDebInfo", ".."
        system "cmake", "--build", "."
        # Thank you Google for providing a convenient install target! /s
        cp_r "../include/openssl",   "#{@boringssl}/include"
        cp "crypto/libcrypto.a",     "#{@boringssl}/lib"
        cp "decrepit/libdecrepit.a", "#{@boringssl}/lib"
        cp "ssl/libssl.a",           "#{@boringssl}/lib"
      end
    end
    ENV["ENGINE"] = "boringssl"
    ENV["ENGINE_INCLUDE_PATH"] = "#{@boringssl}/include"
    ENV["ENGINE_LIB_PATH"] = "#{@boringssl}/lib"
    ENV["PREFIX"] = prefix
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOF
      #include <themis/themis.h>
      int main(void)
      {
        printf("%s", themis_version());
        return 0;
      }
    EOF
    system ENV.cc, "test.c", "-o", "check-themis-version", "-lthemis"
    version = shell_output("./check-themis-version")
    # The 0.10 release is slightly buggy and identifies itself as 0.9
    assert_match(/\bthemis 0.9\b/, version)
  end
end
