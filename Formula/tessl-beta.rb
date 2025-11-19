require_relative "./tessl.rb"
class TesslBeta < Tessl
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/0.50.6-beta.2.tgz"
  sha256 "6e3b466f652c141c80c972ffdcb42ea456fd43be17e4e7f7980ee677c7d74df6"
  license ""

  depends_on "node"

  option "with-version", "Install the test release"
  if build.with?("version") && ENV["HOMEBREW_TESSL_VERSION"]
    url "https://install.tessl.io/releases/#{ENV["HOMEBREW_TESSL_VERSION"].sub("+", "%2B")}.tgz"
    sha256 ""
  end
end
