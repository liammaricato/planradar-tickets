require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      name: "MyString",
      mail: "MyString",
      send_due_date_reminder: true,
      due_date_reminder_interval: 1,
      timezone: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[mail]"

      assert_select "input[name=?]", "user[send_due_date_reminder]"

      assert_select "input[name=?]", "user[due_date_reminder_interval]"

      assert_select "input[name=?]", "user[timezone]"
    end
  end
end
