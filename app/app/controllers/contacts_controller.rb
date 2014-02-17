class ContactsController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @contacts = Contact.all

    if !@contacts.empty?
      respond_with(@contacts)
    else
      render :empty
    end
  end

  def show
    @contact = Contact.find(params[:id])
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.user = current_user

    respond_with(@contact) do |format|
      if @contact.save
        flash[:notice] = 'Contact was succesfully created.'
        format.html { redirect_to contacts_path }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        flash[:error] = @contact.errors
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:notice] = 'Contact was successfully removed.'
    redirect_to contacts_path
  end

end
