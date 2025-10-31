require_relative "./tessl.rb"
class TesslBeta < Tessl
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/nightly-251103.tgz"
  sha256 "323ba922a239123d4fed5fd130351661b062ea59cabcad2e268a9fd219ed5926"
  license ""

  depends_on "node"

end
