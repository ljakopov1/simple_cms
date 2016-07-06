class SubjectsController < ApplicationController

	layout "admin"
  
  before_action :confirm_logged_in

  def index
  	@subjects=Subject.sorted
  end

  def show
  	@subject=Subject.find(params[:id])
  end

  def new
  	@subject=Subject.new({:name=>"Default"})
    @subject_count=Subject.count + 1
  end

  def create
  	#1. prvi korak, kreiranje novog objekta
  	@subject=Subject.new(subject_params)
  	#2. spremanje objekata
  	if @subject.save
  		#ako spremanje uspije, idi u index
  		flash[:notice]="Subject created successfully."
  		redirect_to(:action => 'index')	
  	else
  		#ako spremanje ne uspije, omogući korisiku da popravi svoju grešku
      @subject_count=Subject.count + 1
  		render('new')
  	end
  end

  def edit
  	  	@subject=Subject.find(params[:id])
        @subject_count=Subject.count
  end

  def update
  	#1. prvi korak, kreiranje novog objekta
  	@subject=Subject.find(params[:id])

  	if @subject.update_attributes(subject_params)
  		#ako ažuriranje podataka uspije
  		flash[:notice]="Subject update successfully."
  		redirect_to(:action => 'show', :id=>@subject.id)	
  	else
  		#ako ažuriranje podataka ne uspije, omogući korisiku da popravi svoju grešku
      @subject_count=Subject.count
  		render('edit')
  	end
  end


  def delete
  	@subject=Subject.find(params[:id])
  end

  def destroy
  	subject=Subject.find(params[:id]).destroy
  	flash[:notice]="Subject '#{subject.name}' destroyed successfully."
  	redirect_to(:action=>'index')
  end


  private
  def subject_params
  	params.require(:subject).permit(:name, :position, :visible)
  end
end


