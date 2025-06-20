require 'rails_helper'

RSpec.describe "tickets/edit", type: :view do
  let(:ticket) {
    Ticket.create!(
      title: "MyString",
      description: "MyText",
      status_id: 1,
      progress: 1,
      users: nil
    )
  }

  before(:each) do
    assign(:ticket, ticket)
  end

  it "renders the edit ticket form" do
    render

    assert_select "form[action=?][method=?]", ticket_path(ticket), "post" do

      assert_select "input[name=?]", "ticket[title]"

      assert_select "textarea[name=?]", "ticket[description]"

      assert_select "input[name=?]", "ticket[status_id]"

      assert_select "input[name=?]", "ticket[progress]"

      assert_select "input[name=?]", "ticket[user_id]"
    end
  end
end
