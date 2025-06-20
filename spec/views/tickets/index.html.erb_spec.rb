require 'rails_helper'

RSpec.describe "tickets/index", type: :view do
  before(:each) do
    assign(:tickets, [
      Ticket.create!(
        title: "Title",
        description: "MyText",
        status_id: 2,
        progress: 3,
        users: nil
      ),
      Ticket.create!(
        title: "Title",
        description: "MyText",
        status_id: 2,
        progress: 3,
        users: nil
      )
    ])
  end

  it "renders a list of tickets" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
