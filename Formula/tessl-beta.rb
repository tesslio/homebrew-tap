require_relative "./tessl.rb"
class TesslBeta < Tessl
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/0.29.0-beta.6.tgz"
  sha256 "edbb5a32a1a2ad0b17d6c8a2eb43163b117531f94f5c7d7f08f249e4d95895f1"
  license ""

  depends_on "node"

  option "with-version", "Install the test release"
  if build.with?("version") && ENV["HOMEBREW_TESSL_VERSION"]
    url "https://install.tessl.io/releases/#{ENV["HOMEBREW_TESSL_VERSION"]}.tgz"
    sha256 ""
  end
end
