require_relative "../lib/cher_depute"

describe "Vérifier le nombre de résultats" do
  it "au minimum 10" do
    expect(connect().count).to be > 10
  end
end
