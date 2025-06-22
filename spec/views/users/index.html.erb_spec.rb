require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, create_list(:user, 2))
  end

  it "renders a list of users" do
    render
    assert_select "p", text: /Name/, count: 2
    assert_select "p", text: /Mail/, count: 2
    assert_select "p", text: /Reminders configured/, count: 2
  end
end
