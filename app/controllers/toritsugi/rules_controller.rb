module Toritsugi
  class RulesController < ApplicationController
    def show
      rule = Rule.find_by!(source: params[:id])
      redirect_to rule.destination
    rescue => e
      render text: "404"
    end
  end
end
