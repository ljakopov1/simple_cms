class PagesController < ApplicationController

  layout "admin"
  before_action :confirm_logged_in

  def index
    @pages=Page.sorted
  end

  def show
    @page=Page.find(params[:id])
  end

  def new
    @page=Page.new
    @subjects = Subject.all
    @page_count = Page.count + 1
  end

  def create
    @page=Page.new(page_params)
    #ako se stranica uspjesno spremi, vracamo se u index.html
    if @page.save
      flash[:notice]="Page created successfuly"
      redirect_to(:action => 'index')
    #ako se stanica ne uspije spremiti, tada omogući korisniku da promjeni navedene podatke
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    @page=Page.find(params[:id])
    @subjects = Subject.all
    @page_count = Page.count + 1
  end

  def update
    @page=Page.find(params[:id])
    #ako je uspješno editiranje podataka
    if @page.update_attributes(page_params)
      flash[:notice]="Page  update successfuly"
      redirect_to(:action=>'show', :id=>@page.id)
    #ako editiranje podataka ne uspije, omogući korisniku da promjeni podatke
    else
      @subjects = Subject.all
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page=Page.find(params[:id])
  end

  def destroy
    @page=Page.find(params[:id]).destroy
    flash[:notice]="Page  destroyed successfuly"
    redirect_to(:action=>'index')
  end

  private
  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

end
