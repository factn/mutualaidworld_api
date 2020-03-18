require "rails_helper"

RSpec.describe "verbs/index", type: :view do
  before(:each) do
    assign(:verbs, [
             Verb.create!(
               description: "Description"
             ),
             Verb.create!(
               description: "Description"
             )
           ])
  end

  it "renders a list of verbs" do
    render
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
