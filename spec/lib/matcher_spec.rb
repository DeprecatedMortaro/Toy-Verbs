require 'spec_helper'

describe SiteController, :type => :controller do

  it "routes to an action" do
    get :root
    response.should render_template(text: 'welcome')
  end

  [:post_comment, :terms_of_use, :contact, :about_us,
   :another_page, :randon_page, :different_page, :hidden_page,
   :post_action, :put_action, :delete_action, :match_action].each do |action|
    it {should respond_to(action)}
  end

  it {should_not respond_to(:edit)}

end
