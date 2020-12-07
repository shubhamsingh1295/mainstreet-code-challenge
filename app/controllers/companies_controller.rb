class CompaniesController < ApplicationController
  before_action :set_company, except: %i[index create new]

  def index
    @companies = Company.paginate(page: params[:page]).order(id: :desc)
  end

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: 'Created.'
    else
      flash.now[:alert] = @company.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: 'Updated.'
    else
      flash.now[:alert] = @company.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: 'Deleted.'
    else
      flash.now[:alert] = @company.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :legal_name, :description, :zip_code,
                                    :phone, :email, :owner_id, :brand_color,
                                    services: [])
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
