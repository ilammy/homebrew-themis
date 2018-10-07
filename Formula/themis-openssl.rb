class ThemisOpenssl < Formula
  desc "High-level cryptographic primitives (OpenSSL flavor)"
  homepage "https://www.cossacklabs.com/themis"
  url "https://github.com/cossacklabs/themis/archive/0.10.0.tar.gz"
  sha256 "329a981e7e57a90107b330172b738104f7189cb20eac043d708c23c5db1570fb"

  depends_on "openssl"
  conflicts_with "themis-libressl", :because => "only one flavor of Themis can exist in PATH"

  def install
    ENV["ENGINE"] = "openssl"
    ENV["ENGINE_INCLUDE_PATH"] = Formula["openssl"].include
    ENV["ENGINE_LIB_PATH"] = Formula["openssl"].lib
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
