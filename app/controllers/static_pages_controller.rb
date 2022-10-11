class StaticPagesController < ApplicationController
  def home
    @pagy, @feed = pagy(current_user.feed)
  end

  def help
  end

  def about
  end

  def contact
  end
end
