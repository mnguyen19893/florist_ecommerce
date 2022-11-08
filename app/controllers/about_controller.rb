class AboutController < ApplicationController
  def index
    @about = About.first
  end

  def contact
    @contact = Contact.first
  end
end
