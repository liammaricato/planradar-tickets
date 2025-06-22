require 'rails_helper'

RSpec.describe "tickets/edit", type: :view do
  let(:ticket) { create(:ticket) }

  before(:each) do
    assign(:ticket, ticket)
  end

  it "renders the edit ticket form" do
    render

    assert_select "form[action=?][method=?]", ticket_path(ticket), "post" do

      assert_select "input[name=?]", "ticket[title]"

      assert_select "textarea[name=?]", "ticket[description]"

      assert_select "select[name=?]", "ticket[user_id]"
    end
  end
end
