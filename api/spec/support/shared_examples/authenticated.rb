shared_examples "it requires a user to be authenticated" do
  it "returns a http status code of 302" do
    sign_out user
    action

    expect(response).to have_http_status :found
  end
end
