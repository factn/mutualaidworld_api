require 'rails_helper'

RSpec.describe "verbs/new", type: :view do
  before(:each) do
    assign(:verb, Verb.new(
      :description => "MyString"
    ))
  end

  it "renders new verb form" do
    render

    assert_select "form[action=?][method=?]", verbs_path, "post" do

      assert_select "input[name=?]", "verb[description]"
    end
  end
end
