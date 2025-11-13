require_relative "./tessl.rb"
class TesslBeta < Tessl
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://tileworks-cli-assets.s3.amazonaws.com/releases/0.50.0-beta.2.tgz"
  sha256 "eaf716fe107ed23c6e4a5cf2a65a4ccbd9f4d84e30b52c3fcaa622b89b12c813  -"
  license ""

  depends_on "node"

  option "with-version", "Install the test release"
  if build.with?("version") && ENV["HOMEBREW_TESSL_VERSION"]
    url "https://tileworks-cli-assets.s3.amazonaws.com/releases/0.50.0-beta.2.tgz"
    sha256 "eaf716fe107ed23c6e4a5cf2a65a4ccbd9f4d84e30b52c3fcaa622b89b12c813  -"
  end
end
