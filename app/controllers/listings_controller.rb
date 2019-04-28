class ListingsController < ApplicationController

  def list
    @items = current_user.items.order("created_at DESC")
  end

  def in_progress
  end

  def completed
  end
end
