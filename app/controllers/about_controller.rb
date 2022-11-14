class AboutController < ApplicationController
  before_action :authenticate_user!

  def index
    @about = About.first
  end

  def contact
    @contact = Contact.first
  end
end
