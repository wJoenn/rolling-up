shared_examples "a JSON endpoint" do
  it "responds with a JSON object" do
    expect(response.parsed_body).to eq JSON.parse(response.body)
  end
end
