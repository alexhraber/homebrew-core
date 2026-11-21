class Decapod < Formula
  desc "Repo-native governance kernel for AI coding agents"
  homepage "https://decapodlabs.ai"
  url "https://github.com/DecapodLabs/decapod/releases/download/v0.158.3/source.tar.gz"
  sha256 "480407e31cf46f9386d14200a4e32faa86248036e6ad3eddce390390ce82fe65"
  license "MIT"

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/decapod system version")

    schema = JSON.parse(shell_output("#{bin}/decapod data schema --deterministic"))
    assert_equal "1.0.0", schema.fetch("schema_version")
    assert schema.fetch("subsystems").key?("todo")
  end
end
