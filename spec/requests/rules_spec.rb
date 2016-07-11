require 'rails_helper'

module Toritsugi
  describe RulesController do
    describe "GET /toritsugi/:id" do
      context "the destination url begin with '/'" do
        let!(:rule) { create(:rule, destination: "/toritsugi_success.html") }

        it "interprets the destination as a same origin path and redirects to the path" do
          get "/toritsugi/#{rule.source}"
          expect(response).to redirect_to(rule.destination)
        end
      end

      context "the destination url begin with scheme specification" do
        let!(:rule) { create(:rule, destination: "https://httpbin.org/") }

        it "interprets the destination as a FQDN and redirects to the url" do
          get "/toritsugi/#{rule.source}"
          expect(response).to redirect_to(rule.destination)
        end
      end

      context "the destination url begin without scheme specification" do
        let!(:rule) { create(:rule, destination: "httpbin.org/") }

        it "assumes that the scheme is http" do
          get "/toritsugi/#{rule.source}"
          expect(response).to redirect_to("http://#{rule.destination}")
        end
      end
    end
  end
end
