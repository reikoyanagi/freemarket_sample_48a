require 'rails_helper'

describe ItemsController, type: :controller do



  describe 'GET #new' do
  let(:user) { create(:user) }
    context 'log in' do
      before do
        login user
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end
    context 'not log in' do
      it 'redirects to user_session_path' do
        get :new
        expect(response).to redirect_to(user_session_path)
      end
    end
  end



  describe 'GET #edit' do
    it "assigns the requested item to @item" do
      item = create(:item)
      uesr = create(:user)
      get :edit, params: { id: item }
      expect(assigns(:item)).to eq item
    end
    it "renders the :edit template" do
      item = create(:item)
      get :edit, params: { id: item }
      expect(response).to render_template :edit
    end
  end



  describe 'GET #index' do
    it "populates an array of items ordered by created_at DESC" do
      items = create_list(:item, 3)
      get :index
      expect(assigns(:items)).to match(items.sort{ |a, b| b.created_at <=> a.created_at } )
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
