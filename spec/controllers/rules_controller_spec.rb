require 'rails_helper'

module Toritsugi
  describe RulesController do
    routes { Engine.routes }

    describe "#after_redirection_callback" do
      let!(:rule) { create(:rule, destination: "/advice") }
      let!(:callback) { -> (request, params, rule) { throw :called } }

      context "after redirection callback is not set in config" do
        it "doesn't calls the after redirection callback" do
          expect {
            get :show, id: 'advice'
          }.not_to throw_symbol :called
        end
      end

      context "after redirection callback is set" do
        before do
          allow(Toritsugi.config).to(
            receive(:after_redirection_callback)
              .and_return(callback)
          )
        end

        it "calls the after redirection callback" do
          expect {
            get :show, id: 'advice'
          }.to throw_symbol :called
        end
      end
    end
  end
end
