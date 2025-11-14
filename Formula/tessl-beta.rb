require_relative "./tessl.rb"
class TesslBeta < Tessl
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/0.50.3-beta.1.tgz"
  sha256 "7adbeb33fb562f0480f77df24d51b55fb9535a8e514e1ddcf35fad9567b5de73"
  license ""

  depends_on "node"

  option "with-version", "Install the test release"
  if build.with?("version") && ENV["HOMEBREW_TESSL_VERSION"]
    url "https://install.tessl.io/releases/#{ENV["HOMEBREW_TESSL_VERSION"].sub("+", "%2B")}.tgz"
    sha256 ""
  end
end
