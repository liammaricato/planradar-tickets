require 'rails_helper'

RSpec.describe "tickets/show", type: :view do
  before(:each) do
    assign(:ticket, create(:ticket))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/User/)
  end
end
