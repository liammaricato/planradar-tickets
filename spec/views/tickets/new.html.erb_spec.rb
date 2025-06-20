require 'rails_helper'

RSpec.describe "tickets/new", type: :view do
  before(:each) do
    assign(:ticket, Ticket.new(
      title: "MyString",
      description: "MyText",
      status_id: 1,
      progress: 1,
      users: nil
    ))
  end

  it "renders new ticket form" do
    render

    assert_select "form[action=?][method=?]", tickets_path, "post" do

      assert_select "input[name=?]", "ticket[title]"

      assert_select "textarea[name=?]", "ticket[description]"

      assert_select "input[name=?]", "ticket[status_id]"

      assert_select "input[name=?]", "ticket[progress]"

      assert_select "input[name=?]", "ticket[user_id]"
    end
  end
end
