class Books::ImportController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if params[:isbn_10].blank?
      head :not_found
    else
      book = Book.build(params.extract!(:isbn_10).permit!, current_user)
      book.save!
      head :ok
    end
  end
end
