require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, create(:user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Mail/)
    expect(rendered).to match(/Reminders configured/)
  end
end
