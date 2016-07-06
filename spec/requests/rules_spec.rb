require 'rails_helper'

module Toritsugi
  describe RulesController do
    describe "GET /toritsugi/:id" do
      let!(:rule) { create(:rule) }

      it "redirects the request to appropriate destination" do
        get "/toritsugi/#{rule.source}"
        expect(response).to redirect_to(rule.destination)
      end
    end
  end
end
