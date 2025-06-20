require 'rails_helper'

RSpec.describe "tickets/show", type: :view do
  before(:each) do
    assign(:ticket, Ticket.create!(
      title: "Title",
      description: "MyText",
      status_id: 2,
      progress: 3,
      users: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
