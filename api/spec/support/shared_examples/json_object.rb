shared_examples "a JSON object" do
  it "responds with a JSON object" do
    expect(response.body).to be_a String
    expect(response.parsed_body).to be_a Hash
  end
end
