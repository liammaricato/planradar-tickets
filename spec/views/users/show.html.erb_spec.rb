require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      name: "Name",
      mail: "Mail",
      send_due_date_reminder: true,
      due_date_reminder_interval: 3,
      timezone: "Timezone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Mail/)
    expect(rendered).to match(/true/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Timezone/)
  end
end
