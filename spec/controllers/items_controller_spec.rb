require 'rails_helper'

describe ItemsController, type: :controller do
  describe 'items_controllerの#newアクション後にnew.hamlに遷移するか' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end
end
