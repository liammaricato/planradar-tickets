require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      name: "MyString",
      mail: "MyString",
      send_due_date_reminder: true,
      due_date_reminder_interval: 1,
      timezone: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[mail]"

      assert_select "input[name=?]", "user[send_due_date_reminder]"

      assert_select "input[name=?]", "user[due_date_reminder_interval]"

      assert_select "input[name=?]", "user[timezone]"
    end
  end
end
