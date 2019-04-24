class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :"/owners/index"
  end

  # CREATE
  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    # Creates a new owner
    @owner = Owner.create(params["owner"])

    # Creates a new pet if new owner adds a new pet name
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    # Redirects to the new owner page after creating the new owner
    redirect "/owners/#{@owner.id}"
  end

  # UPDATE
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  # PATCH/UPDATE
  patch '/owners/:id' do
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])

    # ActiveRecord .update method
    @owner.update(params["owner"])

    # If the new pet name field is not empty, create and link pet to owner
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    # Redirects back to owner's page after updating
    redirect "owners/#{@owner.id}"
  end
end
