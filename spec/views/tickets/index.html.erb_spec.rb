require 'rails_helper'

RSpec.describe "tickets/index", type: :view do
  before(:each) do
    assign(:tickets, create_list(:ticket, 3))
  end

  it "renders a list of tickets" do
    render
    assert_select "p", text: /Title/, count: 3
    assert_select "p", text: /Description/, count: 3
    assert_select "p", text: /User/, count: 3
  end
end
