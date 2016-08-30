require 'rails_helper'
 
describe User do
  it 'can be created' do
    post = User.create!(email: "My email", password: "The encrypted password")
    expect(post).to be_valid
  end
end

 
