class LoansController < ApplicationController
  def index
  	@loanables = Item.where('is_loanable = 1').order(:name)
  	@loaned = Loan.joins(:item).where(:status => Loan::LOANED).order('items.name')
  end
end
