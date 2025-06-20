require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        name: "Name",
        mail: "Mail",
        send_due_date_reminder: true,
        due_date_reminder_interval: 3,
        timezone: "Timezone"
      ),
      User.create!(
        name: "Name",
        mail: "Mail",
        send_due_date_reminder: true,
        due_date_reminder_interval: 3,
        timezone: "Timezone"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Mail".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(true.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Timezone".to_s), count: 2
  end
end
